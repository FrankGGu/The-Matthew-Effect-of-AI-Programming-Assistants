-module(maximal_network_rank).
-export([maxNetworkRank/2]).

maxNetworkRank(Edges, N) ->
    Degree = lists:seq(0, N-1),
    DegreeMap = lists:foldl(fun({A, B}, Acc) ->
        Acc#{A => maps:get(A, Acc, 0) + 1, B => maps:get(B, Acc, 0) + 1}
    end, #{}, Edges),
    MaxRank = lists:max([maps:get(I, DegreeMap, 0) || I <- Degree]),
    Candidates = [I || I <- Degree, maps:get(I, DegreeMap, 0) == MaxRank],
    findMaxPair(Candidates, Edges, DegreeMap).

findMaxPair([], _, _) -> 0;
findMaxPair([H | T], Edges, DegreeMap) ->
    Max = lists:max([maps:get(H, DegreeMap, 0) + maps:get(J, DegreeMap, 0) - (if lists:member({H, J}, Edges) orelse lists:member({J, H}, Edges) -> 1; true -> 0 end) || J <- T]),
    max(Max, findMaxPair(T, Edges, DegreeMap)).