-module(solution).
-export([findingUsersActiveMinutes/2]).

process_log_entry([UserId, Minute], UserMinutesMap) ->
    CurrentMinutes = maps:get(UserId, UserMinutesMap, sets:new()),
    UpdatedMinutes = sets:add_element(Minute, CurrentMinutes),
    maps:put(UserId, UpdatedMinutes, UserMinutesMap).

update_uam_counts_map(UAM, AccUAMCountsMap) ->
    CurrentCount = maps:get(UAM, AccUAMCountsMap, 0),
    maps:put(UAM, CurrentCount + 1, AccUAMCountsMap).

findingUsersActiveMinutes(Logs, K) ->
    UserMinutesMap = lists:foldl(fun process_log_entry/2, maps:new(), Logs),

    AllUAMs = lists:map(fun({_User, MinutesSet}) -> sets:size(MinutesSet) end, maps:to_list(UserMinutesMap)),

    FilteredUAMs = lists:filter(fun(UAM) -> UAM >= 1 andalso UAM =< K end, AllUAMs),

    UAMCountsMap = lists:foldl(fun update_uam_counts_map/2, maps:new(), FilteredUAMs),

    [ maps:get(I, UAMCountsMap, 0) || I <- lists:seq(1, K) ].