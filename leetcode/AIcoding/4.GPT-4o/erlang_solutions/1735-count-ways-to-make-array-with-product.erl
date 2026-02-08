-module(solution).
-export([count_ways/1]).

count_ways(N) when N > 0 ->
    count_ways(N, 1, 0).

count_ways(0, _, Ways) -> Ways;
count_ways(N, Product, Ways) ->
    NewWays = if
        Product rem 2 =:= 0 -> Ways + 1;
        true -> Ways
    end,
    count_ways(N-1, Product * 2, NewWays).