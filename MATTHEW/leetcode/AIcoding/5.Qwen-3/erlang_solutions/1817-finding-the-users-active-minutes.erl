-module(leetcode).
-export([finding_users_active_minutes/1]).

finding_users_active_minutes(Users) ->
    Map = lists:foldl(fun({UserId, Time}, Acc) ->
        case maps:find(UserId, Acc) of
            {ok, Times} ->
                maps:put(UserId, [Time | Times], Acc);
            error ->
                maps:put(UserId, [Time], Acc)
        end
    end, #{}, Users),
    Lists = maps:values(Map),
    Counts = lists:foldl(fun(List, Acc) ->
        Len = length(lists:usort(List)),
        case maps:find(Len, Acc) of
            {ok, C} -> maps:put(Len, C + 1, Acc);
            error -> maps:put(Len, 1, Acc)
        end
    end, #{}, Lists),
    maps:values(Counts).