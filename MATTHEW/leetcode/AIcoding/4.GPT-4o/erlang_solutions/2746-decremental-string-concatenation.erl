-module(solution).
-export([concatenate/1]).

concatenate(List) ->
    List1 = lists:map(fun(X) -> string:to_lower(X) end, List),
    concatenate_helper(List1, []).

concatenate_helper([], Acc) ->
    lists:reverse(Acc);
concatenate_helper([H | T], Acc) ->
    NewAcc = [H | Acc],
    concatenate_helper(T, NewAcc).