-module(solution).
-export([earliest_bloom/2]).

earliest_bloom/2 ->
    {N, Plant, Grow} = {length(Plant), Plant, Grow},
    P = lists:zip(Plant, Grow),
    Sorted = lists:sort(fun({P1, G1}, {P2, G2}) -> P1 + G1 < P2 + G2 end, P),
    lists:foldl(fun({P, G}, Acc) -> max(Acc, P + G) end, 0, Sorted).