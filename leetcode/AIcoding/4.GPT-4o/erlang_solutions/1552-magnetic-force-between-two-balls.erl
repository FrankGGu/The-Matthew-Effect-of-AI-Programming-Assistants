-module(solution).
-export([maxDistance/2]).

maxDistance(positions, m) ->
    SortedPositions = lists:sort(positions),
    MinDistance = 1,
    MaxDistance = hd(SortedPositions) - hd(tl(SortedPositions)),
    binary_search(SortedPositions, m, MinDistance, MaxDistance).

binary_search(_, _, Low, High) when Low >= High -> Low;
binary_search(Positions, M, Low, High) ->
    Mid = (Low + High + 1) div 2,
    if can_place(Positions, M, Mid) -> 
        binary_search(Positions, M, Mid, High);
    true -> 
        binary_search(Positions, M, Low, Mid - 1)
    end.

can_place(Positions, M, MinDist) ->
    N = length(Positions),
    {_, Count} = lists:foldl(fun(P, {LastPos, Count}) ->
        if Count >= M -> {LastPos, Count};
           LastPos + MinDist =< P -> {P, Count + 1};
           true -> {LastPos, Count}
        end
    end, {hd(Positions) - MinDist, 0}, tl(Positions)),
    Count >= M.