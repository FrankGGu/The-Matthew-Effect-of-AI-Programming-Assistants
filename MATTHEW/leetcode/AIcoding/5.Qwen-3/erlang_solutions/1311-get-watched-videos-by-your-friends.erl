-module(solution).
-export([watched_videos_by_friends/2]).

watched_videos_by_friends(Users, K) ->
    Friends = get_friends(Users),
    FriendsVideos = get_videos(Friends, Users),
    sort_videos(FriendsVideos).

get_friends(Users) ->
    Friends = lists:foldl(fun({Id, _}, Acc) -> maps:put(Id, [], Acc) end, #{}, Users),
    lists:foreach(fun({Id, FriendsList}) -> 
        lists:foreach(fun(FriendId) -> 
            maps:update_with(FriendId, fun(V) -> [Id | V] end, [Id], Friends)
        end, FriendsList)
    end, Users),
    Friends.

get_videos(Friends, Users) ->
    lists:foldl(fun({FriendId, _}, Acc) ->
        case lists:keyfind(FriendId, 1, Users) of
            {FriendId, Videos} -> 
                lists:foldl(fun(V, Acc2) -> [V | Acc2] end, Acc, Videos);
            false -> Acc
        end
    end, [], maps:to_list(Friends)).

sort_videos(Videos) ->
    lists:usort(Videos).