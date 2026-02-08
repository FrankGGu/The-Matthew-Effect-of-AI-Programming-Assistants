-module(watched_videos).
-export([watched_videos/3]).

watched_videos(WatchedVideos, Friends, ID, Level) ->
  FriendList = get_friends(Friends, ID, Level, []),
  Videos = get_videos(WatchedVideos, FriendList),
  lists:sort(fun({V1, C1}, {V2, C2}) ->
                   if C1 < C2 ->
                     true;
                   C1 > C2 ->
                     false;
                   V1 < V2 ->
                     true;
                   true ->
                     false
                   end
               end,
             lists:map(fun(V) -> {V, lists:foldl(fun(X, Acc) -> if X == V -> Acc + 1; true -> Acc end, 0, Videos)} end, lists:usort(Videos))).
  lists:map(fun({V, _}) -> V end, lists:sort(fun({V1, C1}, {V2, C2}) ->
                   if C1 < C2 ->
                     true;
                   C1 > C2 ->
                     false;
                   V1 < V2 ->
                     true;
                   true ->
                     false
                   end
               end,
             lists:map(fun(V) -> {V, lists:foldl(fun(X, Acc) -> if X == V -> Acc + 1; true -> Acc end, 0, Videos)} end, lists:usort(Videos)))).

get_friends(Friends, ID, 0, Acc) ->
  Acc;
get_friends(Friends, ID, Level, Acc) ->
  FriendsInLevel = get_friends_at_level(Friends, ID, Level, [], [ID]),
  get_friends(Friends, ID, Level - 1, Acc ++ FriendsInLevel).

get_friends_at_level(Friends, ID, Level, Acc, Visited) ->
  if Level == 1 ->
    lists:filter(fun(F) -> not lists:member(F, Visited) end, lists:nth(ID + 1, Friends));
  true ->
    NextLevel = lists:flatten([lists:filter(fun(F) -> not lists:member(F, Visited) end, lists:nth(Friend + 1, Friends)) || Friend <- Visited]),
    get_friends_at_level(Friends, ID, Level - 1, Acc, lists:usort(Visited ++ NextLevel))
  end.

get_videos(WatchedVideos, FriendList) ->
  lists:flatten([lists:nth(Friend + 1, WatchedVideos) || Friend <- FriendList]).