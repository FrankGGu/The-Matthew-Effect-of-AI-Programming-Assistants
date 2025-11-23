-module(solution).
-export([countTestedDevices/1]).

countTestedDevices(BatteryPercentages) ->
    countTestedDevices(BatteryPercentages, 0, 0).

countTestedDevices([], _, Count) ->
    Count;
countTestedDevices([H|T], Power, Count) ->
    case H > Power of
        true ->
            countTestedDevices(T, Power + 1, Count + 1);
        false ->
            countTestedDevices(T, Power, Count)
    end.