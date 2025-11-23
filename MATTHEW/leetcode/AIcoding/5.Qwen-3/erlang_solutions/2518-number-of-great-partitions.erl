-module(number_of_great_partitions).
-export([num_great_partitions/1]).

num_great_partitions(Nums) ->
    num_great_partitions(Nums, 0, 0, 0, 0).

num_great_partitions([], _, _, Count, _) ->
    Count;
num_great_partitions([N | Rest], Sum, Count, Max, Min) ->
    NewSum = Sum + N,
    NewMax = max(Max, N),
    NewMin = min(Min, N),
    if
        NewSum > NewMax + NewMin ->
            num_great_partitions(Rest, NewSum, Count + 1, NewMax, NewMin);
        true ->
            num_great_partitions(Rest, NewSum, Count, NewMax, NewMin)
    end.