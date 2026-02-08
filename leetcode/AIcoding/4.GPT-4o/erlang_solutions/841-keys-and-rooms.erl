-module(solution).
-export([can_visit_all_rooms/1]).

can_visit_all_rooms(Rooms) ->
    can_visit_all_rooms(Rooms, [0], []).

can_visit_all_rooms(_, [], Visited) ->
    length(Visited) =:= length(Rooms);
can_visit_all_rooms(Rooms, [Room | Rest], Visited) ->
    NewVisited = lists:usort([Room | Visited]),
    NewKeys = lists:subtract(Rooms(Room), NewVisited),
    can_visit_all_rooms(Rooms, Rest ++ NewKeys, NewVisited).