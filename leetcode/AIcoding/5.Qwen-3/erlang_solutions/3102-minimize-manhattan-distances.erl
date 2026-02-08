-module(minimize_manhattan_distances).
-export([minimumTotalDistance/1]).

minimumTotalDistance(Workers) ->
    WorkersSorted = lists:sort(Workers),
    [Worker | _] = WorkersSorted,
    [WorkerX, WorkerY] = Worker,
    Minimum = minimumTotalDistance(WorkersSorted, WorkerX, WorkerY, 0),
    Minimum.

minimumTotalDistance([], _, _, Acc) ->
    Acc;
minimumTotalDistance([Worker | Rest], X, Y, Acc) ->
    [WX, WY] = Worker,
    Dist = abs(WX - X) + abs(WY - Y),
    minimumTotalDistance(Rest, WX, WY, Acc + Dist).