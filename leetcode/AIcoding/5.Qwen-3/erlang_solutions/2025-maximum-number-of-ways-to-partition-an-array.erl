-module(maximum_number_of_ways_to_partition_an_array).
-export([waysToPartition/1]).

waysToPartition(Nums) ->
    N = length(Nums),
    Sum = lists:sum(Nums),
    Map = maps:new(),
    waysToPartition(Nums, 0, 0, Sum, Map, N, 0).

waysToPartition([], _, _, _, _, _, Acc) ->
    Acc;
waysToPartition([H | T], LeftSum, RightSum, Total, Map, N, Acc) ->
    NewRightSum = RightSum + H,
    NewLeftSum = LeftSum + H,
    if
        NewRightSum == Total - NewRightSum ->
            waysToPartition(T, NewLeftSum, NewRightSum, Total, Map, N, Acc + 1);
        true ->
            Count = maps:get(NewRightSum, Map, 0),
            waysToPartition(T, NewLeftSum, NewRightSum, Total, Map, N, Acc + Count)
    end.