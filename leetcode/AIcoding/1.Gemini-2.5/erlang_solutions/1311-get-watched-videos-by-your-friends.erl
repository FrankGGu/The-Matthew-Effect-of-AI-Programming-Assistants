-module(solution).
-export([getWatchedVideosByFriends/5]).

getWatchedVideosByFriends(_NumUsers, Friends, WatchedVideos, Id, Level) ->
    UsersAtLevel = bfs(Id, Friends, Level),

    AllVideos = lists:flatmap(fun(User) -> lists:nth(User + 1, WatchedVideos) end, UsersAtLevel),

    VideoCounts = lists:foldl(
        fun(Video, AccMap) ->
            maps:update_with(Video, fun(Count) -> Count + 1 end, 1, AccMap)
        end,
        #{},
        AllVideos
    ),

    SortedVideos = lists:sort(
        fun({V1, C1}, {V2, C2}) ->
            if
                C1 =:= C2 -> V1 < V2;
                true -> C1 < C2
            end
        end,
        maps:to_list(VideoCounts)
    ),

    [V || {V, _C} <- SortedVideos].

bfs(StartId, FriendsGraph, TargetLevel) ->
    bfs_loop([{StartId, 0}], sets:add_element(StartId, sets:new()), FriendsGraph, TargetLevel, [], []).

bfs_loop([{User, Dist} | RestCurrentLevelQueue], Visited, FriendsGraph, TargetLevel, AccUsersAtTargetLevel, NextLevelQueueAcc) ->
    case Dist of
        TargetLevel ->
            bfs_loop(RestCurrentLevelQueue, Visited, FriendsGraph, TargetLevel, [User | AccUsersAtTargetLevel], NextLevelQueueAcc);
        _ when Dist < TargetLevel ->
            Neighbors = lists:nth(User + 1, FriendsGraph),
            {NewNextLevelQueueAcc, NewVisited} = lists:foldl(
                fun(Neighbor, {QAcc, V}) ->
                    case sets:is_element(Neighbor, V) of
                        true -> {QAcc, V};
                        false -> {[{Neighbor, Dist + 1}] | QAcc, sets:add_element(Neighbor, V)}
                    end
                end,
                {NextLevelQueueAcc, Visited},
                Neighbors
            ),
            bfs_loop(RestCurrentLevelQueue, NewVisited, FriendsGraph, TargetLevel, AccUsersAtTargetLevel, NewNextLevelQueueAcc);
        _ ->
            bfs_loop(RestCurrentLevelQueue, Visited, FriendsGraph, TargetLevel, AccUsersAtTargetLevel, NextLevelQueueAcc)
    end;
bfs_loop([], Visited, FriendsGraph, TargetLevel, AccUsersAtTargetLevel, NextLevelQueueAcc) ->
    case NextLevelQueueAcc of
        [] ->
            lists:reverse(AccUsersAtTargetLevel);
        _ ->
            bfs_loop(lists:reverse(NextLevelQueueAcc), Visited, FriendsGraph, TargetLevel, AccUsersAtTargetLevel, [])
    end.