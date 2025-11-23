-module(min_moves_to_clean_the_classroom).
-export([minMovesToCleanTheClassroom/1]).

minMovesToCleanTheClassroom(Seats) ->
    Rows = length(Seats),
    Cols = length(hd(Seats)),
    {X, Y} = find_robot(Seats, 0, 0),
    Cleaned = lists:foldl(fun(S, Acc) -> lists:foldl(fun(C, A) -> if S == 1 -> A + 1; true -> A end end, Acc, C) end, 0, Seats),
    min_moves(X, Y, Seats, 0, 0, Cleaned).

find_robot([], _, _) -> {0, 0};
find_robot([H | T], Row, Col) ->
    case lists:keymember(2, 1, H) of
        true -> {Row, Col};
        false -> find_robot(T, Row + 1, 0)
    end.

min_moves(_, _, _, _, _, 0) -> 0;
min_moves(X, Y, Seats, Dist, Visited, Cleaned) ->
    Neighbors = get_neighbors(X, Y, Seats),
    Min = lists:foldl(fun({NX, NY}, Acc) ->
        if not lists:member({NX, NY}, Visited) ->
            NewVisited = [{NX, NY} | Visited],
            NewDist = Dist + 1,
            NewCleaned = if Seats!!NX!!NY == 1 -> Cleaned - 1; true -> Cleaned end,
            Result = min_moves(NX, NY, Seats, NewDist, NewVisited, NewCleaned),
            if Result < Acc -> Result; true -> Acc end;
        true -> Acc
    end, infinity, Neighbors),
    Min.

get_neighbors(X, Y, Seats) ->
    Rows = length(Seats),
    Cols = length(hd(Seats)),
    Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
    lists:filter(fun({DX, DY}) ->
        NX = X + DX,
        NY = Y + DY,
        NX >= 0 andalso NX < Rows andalso NY >= 0 andalso NY < Cols
    end, Directions).