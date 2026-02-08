-module(solution).
-export([sortThePeople/2]).

sortThePeople(Names, Heights) ->
    Paired = lists:zip(Heights, Names),
    NegatedHeightPaired = lists:map(fun({H, N}) -> {-H, N} end, Paired),
    SortedByNegatedHeight = lists:sort(NegatedHeightPaired),
    lists:map(fun({_, N}) -> N end, SortedByNegatedHeight).