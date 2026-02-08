-module(solution).
-export([repairCars/2]).

repairCars(N, times) ->
    Min = 1,
    Max = lists:max(times),
    repairCarsHelper(N, times, Min, Max).

repairCarsHelper(N, Times, Min, Max) when Min < Max ->
    Mid = (Min + Max) div 2,
    Total = lists:sum(lists:map(fun(X) -> (X div Mid) + (if X rem Mid =:= 0 -> 0; true -> 1 end) end, Times)),
    if
        Total > N ->
            repairCarsHelper(N, Times, Mid + 1, Max);
        true ->
            repairCarsHelper(N, Times, Min, Mid
    end;
repairCarsHelper(_, _, Min, Max) ->
    Min.