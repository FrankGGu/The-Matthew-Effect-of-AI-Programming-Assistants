-module(solution).
-export([minimum_time_to_repair_cars/2]).

minimum_time_to_repair_cars(Ranks, Cars) ->
    MaxRank = lists:max(Ranks),
    Low = 0,
    High = MaxRank * Cars * Cars,
    binary_search(Low, High, High, Ranks, Cars).

binary_search(Low, High, Ans, Ranks, Cars) ->
    if
        Low > High -> Ans;
        true ->
            Mid = Low + (High - Low) div 2,
            if
                check(Mid, Ranks, Cars) ->
                    binary_search(Low, Mid - 1, Mid, Ranks, Cars);
                true ->
                    binary_search(Mid + 1, High, Ans, Ranks, Cars)
            end
    end.

check(Time, Ranks, Cars) ->
    TotalCarsRepaired = lists:foldl(fun(R, Acc) ->
                                        MaxCarsForThisMechanic = trunc(math:sqrt(Time / R)),
                                        Acc + MaxCarsForThisMechanic
                                    end, 0, Ranks),
    TotalCarsRepaired >= Cars.