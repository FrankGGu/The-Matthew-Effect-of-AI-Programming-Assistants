-module(solution).
-export([isValid/1]).

isValid(S) ->
    check(S, []).

check([], Stack) ->
    Stack == [];
check([$c | T], [$b, $a | Stack]) ->
    check(T, Stack);
check([H | T], Stack) ->
    check(T, [H | Stack]).