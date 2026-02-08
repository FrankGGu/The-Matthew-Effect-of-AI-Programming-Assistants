-module(solution).
-export([num_ways/1]).

num_ways(N) ->
    num_ways(N, 1, 1, 0).

num_ways(N, Power, Current, Count) when Current > N ->
    Count;
num_ways(N, Power, Current, Count) ->
    NextPower = Power + 1,
    NextCurrent = Current * (2 * Power),
    if
        NextCurrent > N ->
            num_ways(N, NextPower, 1, Count + 1);
        true ->
            num_ways(N, NextPower, 1, Count)
    end.