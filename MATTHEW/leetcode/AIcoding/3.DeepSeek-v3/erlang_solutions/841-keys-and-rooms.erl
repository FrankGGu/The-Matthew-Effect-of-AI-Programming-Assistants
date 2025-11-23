-spec can_visit_all_rooms(Rooms :: [[integer()]]) -> boolean().
can_visit_all_rooms(Rooms) ->
    N = length(Rooms),
    Visited = sets:new(),
    dfs(0, Rooms, sets:add_element(0, Visited)),
    sets:size(Visited) =:= N.

dfs(Room, Rooms, Visited) ->
    Keys = lists:nth(Room + 1, Rooms),
    lists:foldl(
        fun(Key, AccVisited) ->
            case sets:is_element(Key, AccVisited) of
                false -> dfs(Key, Rooms, sets:add_element(Key, AccVisited));
                true -> AccVisited
            end
        end,
        Visited,
        Keys
    ).