-module(find_active_minutes).
-export([finding_users_active_minutes/2]).

finding_users_active_minutes(Logs, K) ->
    UserActivities = lists:foldl(
        fun({UserId, Time}, Acc) ->
            case maps:is_key(UserId, Acc) of
                true ->
                    maps:update(UserId, sets:add_element(Time, maps:get(UserId, Acc)), Acc);
                false ->
                    maps:put(UserId, sets:new([Time]), Acc)
            end
        end,
        maps:new(),
        Logs
    ),
    UserActivitySizes = [sets:size(V) || V <- maps:values(UserActivities)],
    Result = lists:foldl(
        fun(Size, Acc) ->
            case Size =< K of
                true ->
                    lists:nth(Size, Acc) + 1;
                false ->
                    lists:nth(K, Acc)
            end
        end,
        lists:seq(1, K, 0),
        UserActivitySizes
    ).