-module(solution).
-export([watchedVideosByFriends/3]).

watchedVideosByFriends(FriendsVideos, FriendID, Level) ->
    watched_videos(FriendsVideos, FriendID, Level, []).

watched_videos(_, [], _, Acc) -> 
    Acc;
watched_videos(FriendsVideos, [H | T], Level, Acc) ->
    case Level of
        0 -> 
            watched_videos(FriendsVideos, T, Level, lists:foldl(fun(X, A) -> 
                lists:append(A, lists:nth(H + 1, FriendsVideos)) 
            end, Acc));
        _ -> 
            watched_videos(FriendsVideos, lists:nth(H + 1, FriendsVideos), Level - 1, Acc)
    end.

watched_videos_by_friends(FriendsVideos, FriendID, Level) ->
    Videos = watched_videos(FriendsVideos, [FriendID], Level, []),
    lists:foldl(fun(X, Acc) -> 
        maps:update_with(X, fun(Count) -> Count + 1 end, 1, Acc) 
    end, #{}, Videos).