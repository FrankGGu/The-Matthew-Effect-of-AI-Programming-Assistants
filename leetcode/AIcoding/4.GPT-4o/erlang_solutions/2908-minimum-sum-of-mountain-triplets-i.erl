-module(solution).
-export([minimum_sum/1]).

minimum_sum(List) ->
    Sorted = lists:sort(List),
    min_sum(Sorted).

min_sum([H1,H2,H3|_]) ->
    H1 + H2 + H3.