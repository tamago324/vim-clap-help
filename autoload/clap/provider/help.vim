" Author: tamago324 <tamago_pad@yahoo.co.jp>
" Description: List the help tags.

scriptencoding utf-8 

let s:save_cpo = &cpoptions
set cpoptions&vim

function! s:help_sink(selected) abort
    execute 'silent help' a:selected
endfunction

function! s:help_source() abort
    let lst = []
    for rtp in split(&runtimepath, ',')
        let path = glob(rtp.'/'.'doc/tags')
        if filereadable(path)
            let tags = map(readfile(path), 'split(v:val)[0]')
            call extend(lst, tags)
        endif
    endfor
    return lst
endfunction

let s:help = {}
let s:help.sink = function('s:help_sink')
let s:help.source = function('s:help_source')
let s:help.on_enter = { -> g:clap.display.setbufvar('&ft', 'clap_help') }

let g:clap#provider#help# = s:help

let &cpoptions = s:save_cpo
unlet s:save_cpo
