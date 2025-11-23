-module(solution).
-export([prefixesDivBy5/1]).

prefixesDivBy5(A) ->
    lists:reverse(prefixesDivBy5_helper(A, 0, [])).

prefixesDivBy5_helper([], _CurrentValMod5, Acc) ->
    Acc;
prefixesDivBy5_helper([H | T], CurrentValMod5, Acc) ->
    NewValMod5 = (CurrentValMod5 * 2 + H) rem 5,
    IsDivisible = (NewValMod5 == 0),
    prefixesDivBy5_helper(T, NewValMod5, [IsDivisible | Acc]).