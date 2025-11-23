-module(solution).
-export([can_visit/1]).

can_visit(Maze) ->
    Start = {0, 0},
    End = {length(Maze) - 1, length(hd(Maze)) - 1},
    visit(Maze, Start, End, #{}, 0).

visit(_, {X, Y}, {X, Y}, _, _) -> 
    true;
visit(Maze, {X, Y}, End, Visited, Steps) when Steps > 1000 ->
    false;
visit(Maze, {X, Y}, End, Visited, Steps) ->
    case maps:is_key({X, Y}, Visited) of
        true -> false;
        false ->
            NextVisited = maps:put({X, Y}, true, Visited),
            Directions = [{X + 1, Y}, {X - 1, Y}, {X, Y + 1}, {X, Y - 1}],
            lists:any(fun({NX, NY}) ->
                is_valid(Maze, {NX, NY}) andalso
                visit(Maze, {NX, NY}, End, NextVisited, Steps + 1)
            end, Directions)
    end.

is_valid(Maze, {X, Y}) ->
    X >= 0 andalso Y >= 0 andalso
    X < length(Maze) andalso Y < length(hd(Maze)) andalso
    lists:nth(Y + 1, lists:nth(X + 1, Maze)) =:= 0.