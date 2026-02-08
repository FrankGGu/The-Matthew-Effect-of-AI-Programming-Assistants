-module(solution).
-export([canReach/2]).

canReach(Maze, start) ->
    Start = tuple_to_list(start),
    Target = tuple_to_list({length(Maze) - 1, length(hd(Maze)) - 1}),
    bfs([{Start, 0}], Maze, Target, []).

bfs([], _, _, _) -> false;
bfs([{Position, _} | Rest], Maze, Target, Visited) ->
    if
        Position =:= Target -> true;
        Position =:= _ =: Visited -> bfs(Rest, Maze, Target, Visited);
        true ->
            NextPositions = get_next_positions(Position, Maze, Visited),
            bfs(Rest ++ NextPositions, Maze, Target, [Position | Visited])
    end.

get_next_positions({X, Y}, Maze, Visited) ->
    Directions = [{1, 0}, {-1, 0}, {0, 1}, {0, -1}],
    lists:filter(fun({NewX, NewY}) -> 
        NewX >= 0, NewY >= 0, 
        NewX < length(Maze), NewY < length(hd(Maze)), 
        not lists:member({NewX, NewY}, Visited), 
        element(NewY + 1, element(NewX + 1, Maze)) =:= 1 
    end, 
    [{X + DX, Y + DY} || {DX, DY} <- Directions]).