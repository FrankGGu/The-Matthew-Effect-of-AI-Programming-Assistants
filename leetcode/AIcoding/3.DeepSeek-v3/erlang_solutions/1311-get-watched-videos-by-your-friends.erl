-spec watched_videos_by_friends(Videos :: [[binary()]], Friends :: [[integer()]], Id :: integer(), Level :: integer()) -> [binary()].
watched_videos_by_friends(Videos, Friends, Id, Level) ->
    Visited = sets:from_list([Id]),
    Queue = queue:in(Id, queue:new()),
    BFS(Friends, Queue, Visited, Level, 0),
    FriendsAtLevel = sets:to_list(Visited) -- [Id],
    VideosList = lists:flatmap(fun(Friend) -> lists:nth(Friend + 1, Videos) end, FriendsAtLevel),
    CountMap = count_videos(VideosList, #{}),
    SortedVideos = lists:sort(fun(V1, V2) ->
        case maps:get(V1, CountMap) =:= maps:get(V2, CountMap) of
            true -> V1 =< V2;
            false -> maps:get(V1, CountMap) =< maps:get(V2, CountMap)
        end
    end, maps:keys(CountMap)),
    SortedVideos.

count_videos([], Map) -> Map;
count_videos([Video | Rest], Map) ->
    case maps:is_key(Video, Map) of
        true -> count_videos(Rest, maps:update(Video, maps:get(Video, Map) + 1, Map);
        false -> count_videos(Rest, maps:put(Video, 1, Map))
    end.

BFS(_Friends, Queue, _Visited, Level, CurrentLevel) when CurrentLevel >= Level -> ok;
BFS(Friends, Queue, Visited, Level, CurrentLevel) ->
    case queue:is_empty(Queue) of
        true -> ok;
        false ->
            {{value, Current}, NewQueue} = queue:out(Queue),
            Neighbors = lists:nth(Current + 1, Friends),
            {UpdatedQueue, UpdatedVisited} = add_neighbors(Neighbors, NewQueue, Visited),
            BFS(Friends, UpdatedQueue, UpdatedVisited, Level, CurrentLevel + 1)
    end.

add_neighbors([], Queue, Visited) -> {Queue, Visited};
add_neighbors([Neighbor | Rest], Queue, Visited) ->
    case sets:is_element(Neighbor, Visited) of
        true -> add_neighbors(Rest, Queue, Visited);
        false ->
            NewQueue = queue:in(Neighbor, Queue),
            NewVisited = sets:add_element(Neighbor, Visited),
            add_neighbors(Rest, NewQueue, NewVisited)
    end.