-module(solution).
-export([count_ways/1]).

count_ways(N) when N < 1 ->
    0;
count_ways(N) ->
    count_ways_helper(N, 0, 1).

count_ways_helper(N, Current, Prev) when Current == N ->
    1;
count_ways_helper(N, Current, Prev) when Current > N ->
    0;
count_ways_helper(N, Current, Prev) ->
    count_ways_helper(N, Current + Prev, Current) + count_ways_helper(N, Current + Current, Prev).