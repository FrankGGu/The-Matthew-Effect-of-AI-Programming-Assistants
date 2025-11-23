-module(solution).
-export([find_center/1]).

find_center(Edges) ->
    Count = length(Edges),
    Total = lists:foldl(fun({X, Y}, Acc) -> [{X, Acc}, {Y, Acc} | Acc] end, [], Edges),
    lists:keysort(2, Total),
    {Center, _} = lists:nth(Count div 2 + 1, Total),
    Center.