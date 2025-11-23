-module(solution).
-export([maximumRobots/3]).

maximumRobots(ChargeTimes, RunningCosts, Budget) ->
    N = length(ChargeTimes),
    ArrayChargeTimes = array:from_list(ChargeTimes),
    ArrayRunningCosts = array:from_list(RunningCosts),
    binary_search(0, N, ArrayChargeTimes, ArrayRunningCosts, Budget, N).

binary_search(Low, High, ArrayChargeTimes, ArrayRunningCosts, Budget, N) ->
    if
        Low > High -> Low - 1;
        true ->
            Mid = Low + (High - Low) div 2,
            case check(Mid, ArrayChargeTimes, ArrayRunningCosts, Budget, N) of
                true -> binary_search(Mid + 1, High, ArrayChargeTimes, ArrayRunningCosts, Budget, N);
                false -> binary_search(Low, Mid - 1, ArrayChargeTimes, ArrayRunningCosts, Budget, N)
            end
    end.

check(K, ArrayChargeTimes, ArrayRunningCosts, Budget, N) ->
    if
        K == 0 -> true;
        true ->
            if
                K > N -> false;
                true ->
                    check_window(K, ArrayChargeTimes, ArrayRunningCosts, Budget, N)
            end
    end.

check_window(K, ArrayChargeTimes, ArrayRunningCosts, Budget, N) ->
    check_window_loop(0, K, ArrayChargeTimes, ArrayRunningCosts, Budget, N, 0, gb_trees:empty()).

check_window_loop(I, K, ArrayChargeTimes, ArrayRunningCosts, Budget, N, CurrentSumRunning, MaxWindow) ->
    if
        I == N -> false;
        true ->
            ChargeTime_I = array:get(I, ArrayChargeTimes),
            RunningCost_I = array:get(I, ArrayRunningCosts),

            NewSumRunning = CurrentSumRunning + RunningCost_I,
            NewMaxWindow = gb_trees:insert({ChargeTime_I, I}, true, MaxWindow),

            if
                I >= K - 1 ->
                    {{MaxCharge, _}, _} = gb_trees:largest(NewMaxWindow),
                    Cost = MaxCharge + K * NewSumRunning,
                    if
                        Cost =< Budget -> true;
                        true ->
                            ChargeTime_ToRemove = array:get(I - K + 1, ArrayChargeTimes),
                            RunningCost_ToRemove = array:get(I - K + 1, ArrayRunningCosts),

                            UpdatedSumRunning = NewSumRunning - RunningCost_ToRemove,
                            UpdatedMaxWindow = gb_trees:delete({ChargeTime_ToRemove, I - K + 1}, NewMaxWindow),

                            check_window_loop(I + 1, K, ArrayChargeTimes, ArrayRunningCosts, Budget, N, UpdatedSumRunning, UpdatedMaxWindow)
                    end;
                true ->
                    check_window_loop(I + 1, K, ArrayChargeTimes, ArrayRunningCosts, Budget, N, NewSumRunning, NewMaxWindow)
            end
    end.