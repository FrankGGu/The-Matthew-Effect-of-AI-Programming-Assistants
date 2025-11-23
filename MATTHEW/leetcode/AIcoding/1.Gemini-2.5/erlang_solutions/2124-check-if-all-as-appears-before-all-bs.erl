-module(solution).
-export([check_string/1]).

check_string(S) ->
    check_recursive(S, false).

check_recursive([], _FoundB) ->
    true;
check_recursive([$a|T], false) ->
    check_recursive(T, false);
check_recursive([$b|T], false) ->
    check_recursive(T, true);
check_recursive([$a|_T], true) ->
    false;
check_recursive([$b|T], true) ->
    check_recursive(T, true).