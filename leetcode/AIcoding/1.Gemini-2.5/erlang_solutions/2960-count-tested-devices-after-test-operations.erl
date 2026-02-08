-module(solution).
-export([count_tested_devices/1]).

count_tested_devices(BatteryPercentages) ->
    count_tested_devices_recursive(BatteryPercentages, 0, 0).

count_tested_devices_recursive([], TestedCount, _ReductionApplied) ->
    TestedCount;
count_tested_devices_recursive([BatteryLevel | Rest], TestedCount, ReductionApplied) ->
    EffectiveBatteryLevel = BatteryLevel - ReductionApplied,
    if
        EffectiveBatteryLevel > 0 ->
            count_tested_devices_recursive(Rest, TestedCount + 1, ReductionApplied + 1);
        true ->
            count_tested_devices_recursive(Rest, TestedCount, ReductionApplied)
    end.