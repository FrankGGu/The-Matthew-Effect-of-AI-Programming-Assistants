-module(solution).
-export([permute_unique/1]).

permute_unique(List) ->
    UniqueList = lists:usort(List),
    permute(UniqueList, []).

permute([], Acc) ->
    [lists:reverse(Acc)];
permute(Remaining, Acc) ->
    [H | T] = Remaining,
    lists:flatmap(fun(X) -> permute(T -- [X], [X | Acc]) end,
                   lists:filter(fun(X) -> X =:= H end, Remaining)) ++
    permute(T, [H | Acc]).