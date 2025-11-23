-module(solution).
-export([first_day_visited_all_rooms/1]).

first_day_visited_all_rooms(Rooms) ->
    N = length(Rooms),
    Visited = lists:seq(0, N-1),
    first_day_visited_all_rooms(Rooms, 0, 0, Visited, sets:new()).

first_day_visited_all_rooms(_, Day, _, _, _) when Day >= length(Rooms) ->
    -1;
first_day_visited_all_rooms(Rooms, Day, Index, Visited, Seen) ->
    Room = lists:nth(Index + 1, Rooms),
    NewSeen = sets:add_element(Room, Seen),
    if
        sets:size(NewSeen) == length(Visited) ->
            Day;
        true ->
            first_day_visited_all_rooms(Rooms, Day + 1, Room, Visited, NewSeen)
    end.