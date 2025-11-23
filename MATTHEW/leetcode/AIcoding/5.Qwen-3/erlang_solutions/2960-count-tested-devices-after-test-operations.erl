-module(count_tested_devices_after_test_operations).
-export([countTestedDevices/1]).

countTestedDevices(Dev) ->
    countTestedDevices(Dev, 0).

countTestedDevices([], _Count) ->
    _Count;
countTestedDevices([H | T], Count) ->
    case H of
        0 -> countTestedDevices(T, Count);
        _ -> countTestedDevices(T, Count + 1)
    end.