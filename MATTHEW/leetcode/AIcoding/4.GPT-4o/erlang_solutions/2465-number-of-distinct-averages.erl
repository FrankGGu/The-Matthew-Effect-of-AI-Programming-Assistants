-module(solution).
-export([distinctAverages/1]).

distinctAverages(List) ->
    Sorted = lists:sort(List),
    Pairs = lists:zip(Sorted, lists:reverse(Sorted)),
    Averages = [element(1, Pair) + element(2, Pair) / 2 || Pair <- Pairs],
    AveragesDistinct = lists:usort(Averages),
    length(AveragesDistinct).