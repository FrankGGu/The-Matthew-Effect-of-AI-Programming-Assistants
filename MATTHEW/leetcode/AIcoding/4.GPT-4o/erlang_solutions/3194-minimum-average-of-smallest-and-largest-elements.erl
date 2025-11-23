-module(solution).
-export([minimum_average/1]).

minimum_average(List) ->
    Sorted = lists:sort(List),
    N = length(Sorted),
    Smallest = hd(Sorted),
    Largest = lists:nth(N, Sorted),
    (Smallest + Largest) / 2.