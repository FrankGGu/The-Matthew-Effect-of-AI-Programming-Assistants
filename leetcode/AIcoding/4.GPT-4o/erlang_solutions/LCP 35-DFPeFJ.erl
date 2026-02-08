-module(solution).
-export([canVisitAllRooms/1]).

canVisitAllRooms(Rooms) ->
    can_visit(Rooms, [0], []).

can_visit(_, [], Visited) -> 
    length(Visited) =:= length(Rooms);
can_visit(Rooms, [Current | Rest], Visited) ->
    NewVisited = lists:usort([Current | Visited]),
    NewKeys = lists:subtract(Rooms[Current], NewVisited),
    can_visit(Rooms, Rest ++ NewKeys, NewVisited).