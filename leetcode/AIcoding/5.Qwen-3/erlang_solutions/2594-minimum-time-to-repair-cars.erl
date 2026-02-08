-module(minimum_time_to_repair_cars).
-export([minimumTime/2]).

minimumTime(Remaining, RepairTimes) ->
    Low = 0,
    High = lists:max(RepairTimes) * lists:sum(Remaining),
    binary_search(Remaining, RepairTimes, Low, High).

binary_search(Remaining, RepairTimes, Low, High) when Low == High ->
    Low;
binary_search(Remaining, RepairTimes, Low, High) ->
    Mid = (Low + High) div 2,
    case can_repair(Remaining, RepairTimes, Mid) of
        true -> binary_search(Remaining, RepairTimes, Low, Mid);
        false -> binary_search(Remaining, RepairTimes, Mid + 1, High)
    end.

can_repair(Remaining, RepairTimes, Time) ->
    Total = lists:foldl(fun(T, Acc) ->
                            Acc + (Time div T)
                        end, 0, RepairTimes),
    Total >= lists:sum(Remaining).