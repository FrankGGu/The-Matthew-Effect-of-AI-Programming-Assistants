-module(minimum_time_to_repair_cars).
-export([minimum_time/2]).

minimum_time(ranks, cars) ->
    minimum_time(ranks, cars, 1, lists:max(ranks) * cars * cars).

minimum_time(Ranks, Cars, Low, High) ->
    if
        Low >= High ->
            Low;
        true ->
            Mid = (Low + High) div 2,
            if
                can_repair(Ranks, Cars, Mid) ->
                    minimum_time(Ranks, Cars, Low, Mid);
                true ->
                    minimum_time(Ranks, Cars, Mid + 1, High)
            end
    end.

can_repair(Ranks, Cars, Time) ->
    Repaired = lists:sum([floor(math:sqrt(Time / Rank)) || Rank <- Ranks]),
    Repaired >= Cars.