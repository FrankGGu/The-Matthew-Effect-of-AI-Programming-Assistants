-module(solution).
-export([maximum_damage/2]).

maximum_damage(Spells, Limit) ->
    lists:foldl(fun(X, Acc) -> max(Acc, lists:sum(lists:sublist(X, 1, Limit))) end, 0, Spells).