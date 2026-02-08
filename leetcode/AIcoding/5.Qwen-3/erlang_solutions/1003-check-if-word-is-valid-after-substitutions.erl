-module(valid_substitution).
-export([isValid/1]).

isValid(S) ->
    check(S, []).

check([], []) -> true;
check([], _) -> false;
check([H|T], Stack) ->
    case Stack of
        [] ->
            check(T, [H]);
        [Last | _] when Last == $a andalso H == $b ->
            check(T, []);
        [Last | _] when Last == $b andalso H == $c ->
            check(T, []);
        _ ->
            check(T, [H | Stack])
    end.