silent setlocal nomodifiable
      \ readonly
      \ noswapfile
      \ nobuflisted
      \ nowrap
      \ buftype=nofile
      \ bufhidden=wipe
      \ cursorline

" Mappings {{{

if !g:flog_has_shown_deprecated_mapping_spelling_warning
  for flog_deprecated_mapping in [
        \ '<Plug>Floggit',
        \ '<Plug>Floghelp',
        \ '<Plug>Flogquit',
        \ '<Plug>Flogtoggleall',
        \ '<Plug>Flogtogglebisect',
        \ '<Plug>Flogtogglenomerges',
        \ '<Plug>Flogupdate',
        \ '<Plug>Flogvnextcommitright',
        \ '<Plug>Flogvprevcommitright',
        \ '<Plug>Flogvsplitcommitright',
        \ '<Plug>Flogyank',
        \ ]
    if hasmapto(flog_deprecated_mapping)
      echoerr 'Waring: using deprecated mapping ' . flog_deprecated_mapping
      echoerr 'Please capitalize flog mappings in the following way: <Plug>Flogmapping to <Plug>FlogMapping'
      let g:flog_has_shown_deprecated_mapping_spelling_warning = 1
      break
    endif
  endfor
endif

if !hasmapto('<Plug>FlogVsplitcommitright')
  nmap <buffer> <CR> <Plug>FlogVsplitcommitright
endif
nnoremap <buffer> <silent> <Plug>FlogVsplitcommitright :vertical belowright Flogsplitcommit<CR>

if !hasmapto('<Plug>FlogVnextcommitright')
  nmap <buffer> <C-N> <Plug>FlogVnextcommitright
  nmap <buffer> ) <Plug>FlogVnextcommitright
endif
if !hasmapto('<Plug>FlogVprevcommitright')
  nmap <buffer> <C-P> <Plug>FlogVprevcommitright
  nmap <buffer> ( <Plug>FlogVprevcommitright
endif
nnoremap <buffer> <silent> <Plug>FlogVnextcommitright :<C-U>call flog#next_commit() \| vertical belowright Flogsplitcommit<CR>
nnoremap <buffer> <silent> <Plug>FlogVprevcommitright :<C-U>call flog#previous_commit() \| vertical belowright Flogsplitcommit<CR>

if !hasmapto('<Plug>FlogVnextrefright')
  nmap <buffer> ]r <Plug>FlogVnextrefright
endif
if !hasmapto('<Plug>FlogVprevrefright')
  nmap <buffer> [r <Plug>FlogVprevrefright
endif
nnoremap <buffer> <silent> <Plug>FlogVnextrefright :<C-U>call flog#next_ref() \| vertical belowright Flogsplitcommit<CR>
nnoremap <buffer> <silent> <Plug>FlogVprevrefright :<C-U>call flog#previous_ref() \| vertical belowright Flogsplitcommit<CR>

if !hasmapto('<Plug>FlogVdiffsplitright')
  nmap <buffer> dd <Plug>FlogVdiffsplitright
  vmap <buffer> dd <Plug>FlogVdiffsplitright
  nmap <buffer> dv <Plug>FlogVdiffsplitright
  vmap <buffer> dv <Plug>FlogVdiffsplitright
endif

nnoremap <buffer> <silent> <Plug>FlogVdiffsplitright :<C-U>call flog#preview_command(flog#format_commit(flog#get_commit_at_current_line(), 'vertical belowright Git diff HEAD %s'))<CR>
vnoremap <buffer> <silent> <Plug>FlogVdiffsplitright :<C-U>call flog#preview_command(flog#format_commit(flog#get_commit_at_selection(), 'vertical belowright Git diff %s', '', 'HEAD'))<CR>

if !hasmapto('<Plug>FlogToggleall')
  nmap <buffer> a <Plug>FlogToggleall
endif
nnoremap <buffer> <silent> <Plug>FlogToggleall :call flog#toggle_all_refs_option()<CR>

if !hasmapto('<Plug>FlogTogglebisect')
  nmap <buffer> gb <Plug>FlogTogglebisect
endif
nnoremap <buffer> <silent> <Plug>FlogTogglebisect :call flog#toggle_bisect_option()<CR>

if !hasmapto('<Plug>FlogTogglenomerges')
  nmap <buffer> gm <Plug>FlogTogglenomerges
endif
nnoremap <buffer> <silent> <Plug>FlogTogglenomerges :call flog#toggle_no_merges_option()<CR>

if !hasmapto('<Plug>FlogTogglereflog')
  nmap <buffer> gr <Plug>FlogTogglereflog
endif
nnoremap <buffer> <silent> <Plug>FlogTogglereflog :call flog#toggle_reflog_option()<CR>

if !hasmapto('<Plug>FlogUpdate')
  nmap <buffer> u <Plug>FlogUpdate
endif
nnoremap <buffer> <silent> <Plug>FlogUpdate :call flog#populate_graph_buffer()<CR>

if !hasmapto('<Plug>FlogGit')
  nmap <buffer> git <Plug>FlogGit
  vmap <buffer> git <Plug>FlogGit
endif
nnoremap <buffer> <Plug>FlogGit :Floggit
vnoremap <buffer> <Plug>FlogGit :Floggit

if !hasmapto('<Plug>FlogYank')
  nmap <buffer> y<C-G> <Plug>FlogYank
  vmap <buffer> y<C-G> <Plug>FlogYank
endif
nnoremap <buffer> <silent> <Plug>FlogYank :call flog#copy_commits()<CR>
vnoremap <buffer> <silent> <Plug>FlogYank :call flog#copy_commits(1)<CR>

if !hasmapto('<Plug>FlogSearch')
  nmap <buffer> g/ <Plug>FlogSearch
endif
nnoremap <buffer> <Plug>FlogSearch :<C-U>Flogupdate -search=

if !hasmapto('<Plug>FlogPatchSearch')
  nmap <buffer> g\ <Plug>FlogPatchSearch
endif
nnoremap <buffer> <Plug>FlogPatchSearch :<C-U>Flogupdate -patch-search=

if !hasmapto('<Plug>FlogQuit')
  nmap <buffer> ZZ <Plug>FlogQuit
  nmap <buffer> gq <Plug>FlogQuit
endif
nnoremap <buffer> <Plug>FlogQuit :call flog#quit()<CR>

if !hasmapto('<Plug>FlogHelp')
  nmap <buffer> g? <Plug>FlogHelp
endif
nnoremap <buffer> <Plug>FlogHelp :help flog-mappings<CR>

if !hasmapto('<Plug>FlogSetskip')
  nmap <buffer> go <Plug>FlogSetskip
endif
nnoremap <buffer> <silent> <Plug>FlogSetskip :<C-U>call flog#set_skip_option(v:count)<CR>

if !hasmapto('<Plug>FlogSkipahead')
  nmap <buffer> ]] <Plug>FlogSkipahead
endif
nnoremap <buffer> <silent> <Plug>FlogSkipahead :<C-U>call flog#change_skip_by_max_count(1 * max([v:count, 1]))<CR>

if !hasmapto('<Plug>FlogSkipback')
  nmap <buffer> [[ <Plug>FlogSkipback
endif
nnoremap <buffer> <silent> <Plug>FlogSkipback :<C-U>call flog#change_skip_by_max_count(-1 * max([v:count, 1]))<CR>

" Fugitive-like mappings {{{

if !hasmapto('<Plug>FlogRevert')
  nmap <buffer> crc <Plug>FlogRevert
  vmap <buffer> crc <Plug>FlogRevert
endif

if !hasmapto('<Plug>FlogRevertnoedit')
  nmap <buffer> crn <Plug>FlogRevertnoedit
  vmap <buffer> crn <Plug>FlogRevertnoedit
endif

nnoremap <buffer> <Plug> FlogRevert :<C-U>call flog#run_command(flog#format_commit(flog#get_commit_at_current_line(), 'Git revert %s'), 1, 1)<CR>
vnoremap <buffer> <Plug> FlogRevert :<C-U>call flog#run_command(flog#format_commit(flog#get_commit_at_selection(1), 'Git revert %s', 'Git revert %s^..%s'), 1, 1)<CR>

nnoremap <buffer> <Plug> FlogRevertnoedit :<C-U>call flog#run_command(flog#format_commit(flog#get_commit_at_current_line(), 'Git revert --no-edit %s'), 1, 1)<CR>
vnoremap <buffer> <Plug> FlogRevertnoedit :<C-U>call flog#run_command(flog#format_commit(flog#get_commit_at_selection(1), 'Git revert --no-edit %s', 'Git revert --no-edit %s^..%s'), 1, 1)<CR>

if !hasmapto('<Plug>FlogGitrevert')
  nmap <buffer> cr<Space> <Plug>FlogGitrevert
endif
nnoremap <buffer> <Plug>FlogGitrevert :Floggit revert<Space>

if !hasmapto('<Plug>FlogGitmerge')
  nmap <buffer> cm<Space> <Plug>FlogGitmerge
endif
nnoremap <buffer> <Plug>FlogGitmerge :Floggit merge<Space>

if !hasmapto('<Plug>FlogCheckout')
  nmap <buffer> coo <Plug>FlogCheckout
endif
nnoremap <buffer> <Plug>FlogCheckout :<C-U>call flog#run_command(flog#format_commit(flog#get_commit_at_current_line(), 'Git checkout %s'), 0, 1)<CR>

if !hasmapto('<Plug>FlogGitcheckout')
  nmap <buffer> co<Space> <Plug>FlogGitcheckout
endif
nnoremap <buffer> <Plug>FlogGitcheckout :Floggit checkout<Space>

if !hasmapto('<Plug>FlogGitbranch')
  nmap <buffer> cb<Space> <Plug>FlogGitbranch
endif
nnoremap <buffer> <Plug>FlogGitbranch :Floggit branch<Space>

" }}}

" }}}

" Commands {{{

command! -buffer Flogsplitcommit call flog#preview_command(flog#format_commit(flog#get_commit_at_current_line(), '<mods> Gsplit %s'))

command! -buffer -range -bang -complete=customlist,flog#complete_git -nargs=* Floggit call flog#run_command('<mods> Git' . <q-args>, 1, 1, !empty('<bang>'))

command! -bang -complete=customlist,flog#complete -nargs=* Flogupdate call flog#update_options([<f-args>], '<bang>' ==# '!')
command! -bang -complete=customlist,flog#complete_refs -nargs=* Flogjump call flog#jump_to_ref(<q-args>)

" }}}

" vim: set et sw=2 ts=2 fdm=marker:
