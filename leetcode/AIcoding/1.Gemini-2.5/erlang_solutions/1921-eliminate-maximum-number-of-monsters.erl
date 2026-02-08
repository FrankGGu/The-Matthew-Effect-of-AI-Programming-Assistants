-module(solution).
-export([eliminateMaximumMonsters/2]).

eliminateMaximumMonsters(Dist, Speed) ->
    ArrivalTimes = lists:map(fun({D, S}) -> D / S end, lists:zip(Dist, Speed)),
    SortedArrivalTimes = lists:sort(ArrivalTimes),
    count_monsters(SortedArrivalTimes, 0, 0).

count_monsters([], _K, Acc) ->
    Acc;
count_monsters([ArrivalTime | Rest], K, Acc) ->
    if
        ArrivalTime > K ->
            count_monsters(Rest, K + 1, Acc + 1);
        true ->
            Acc
    end.