-module(number_of_ways_to_arrive_at_destination).
-export([countWays/1]).

countWays(NumNodes) ->
    countWays(NumNodes, 1, 0, 0).

countWays(NumNodes, Node, Dist, Count) when Node == NumNodes ->
    Count;
countWays(NumNodes, Node, Dist, Count) ->
    lists:foldl(
        fun(NextNode, Acc) ->
            NewDist = Dist + 1,
            case NextNode of
                _ when NextNode > NumNodes -> Acc;
                _ ->
                    countWays(NumNodes, NextNode, NewDist, Acc + 1)
            end
        end,
        Count,
        lists:seq(Node + 1, NumNodes)
    ).