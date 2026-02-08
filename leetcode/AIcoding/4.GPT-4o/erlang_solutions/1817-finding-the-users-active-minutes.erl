-module(solution).
-export([finding_users_active_minutes/2]).

finding_users_active_minutes(UserIds, Timings) ->
    Timings1 = lists:map(fun({UserId, Time}) -> {UserId, Time} end, Timings),
    UserMap = maps:fold(fun({UserId, Time}, Acc) ->
        maps:update_with(UserId, fun(X) -> lists:usort([Time | X]) end, [Time], Acc)
    end, maps:new(), Timings1),
    ActiveMinutes = maps:map(fun(_, V) -> length(V) end, UserMap),
    lists:foldl(fun({UserId, Count}, Acc) ->
        lists:insert(Count, Acc)
    end, [], maps:to_list(ActiveMinutes)).