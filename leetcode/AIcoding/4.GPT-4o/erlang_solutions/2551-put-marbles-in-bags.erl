-module(solution).
-export([putMarbles/2]).

putMarbles(Bags, MaxWeight) ->
    SortedMarbles = lists:sort(Bags),
    MaxSum = lists:nth(length(Bags), SortedMarbles) + lists:nth(length(Bags) - 1, SortedMarbles),
    MinSum = lists:nth(1, SortedMarbles) + lists:nth(2, SortedMarbles),
    MaxSum - MinSum.