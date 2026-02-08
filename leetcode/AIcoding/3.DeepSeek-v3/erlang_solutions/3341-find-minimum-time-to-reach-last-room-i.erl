-module(solution).
-export([minimum_time/1]).

minimum_time(Rooms) ->
    N = length(Rooms),
    Visited = array:new([{size, N}, {default, false}]),
    {Time, _} = dfs(0, Rooms, Visited, 0),
    Time.

dfs(Room, Rooms, Visited, CurrentTime) ->
    case array:get(Room, Visited) of
        true -> {CurrentTime, Visited};
        false ->
            UpdatedVisited = array:set(Room, true, Visited),
            Keys = lists:nth(Room + 1, Rooms),
            SortedKeys = lists:sort(Keys),
            {NewTime, NewVisited} = lists:foldl(
                fun(Key, {AccTime, AccVisited}) ->
                    {Time, UpdatedAccVisited} = dfs(Key, Rooms, AccVisited, AccTime + 1),
                    {Time, UpdatedAccVisited}
                end,
                {CurrentTime + 1, UpdatedVisited},
                SortedKeys
            ),
            {NewTime, NewVisited}
    end.