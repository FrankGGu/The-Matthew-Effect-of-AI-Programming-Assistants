-spec count_test_devices(Devices :: [integer()]) -> integer().
count_test_devices(Devices) ->
    count_test_devices(Devices, 0).

count_test_devices([], Count) ->
    Count;
count_test_devices([Device | Rest], Count) when Device > Count ->
    count_test_devices(Rest, Count + 1);
count_test_devices([_ | Rest], Count) ->
    count_test_devices(Rest, Count).