-module(solution).
-export([can_escape/2]).

can_escape(Maze, Start) ->
    Exit = {length(Maze) - 1, length(hd(Maze)) - 1},
    can_escape(Maze, Start, Exit, []).

can_escape(_, {X, Y}, Exit, _) when {X, Y} =:= Exit ->
    true;
can_escape(Maze, {X, Y}, Exit, Visited) when X < 0; Y < 0; X >= length(Maze); Y >= length(hd(Maze)) ->
    false;
can_escape(Maze, {X, Y}, Exit, Visited) ->
    if
        lists:member({X, Y}, Visited) ->
            false;
        lists:nth(X + 1, Maze) =:= "0" ->
            can_escape(Maze, {X + 1, Y}, Exit, [{X, Y} | Visited});
        lists:nth(X + 1, Maze) =:= "1" ->
            can_escape(Maze, {X, Y + 1}, Exit, [{X, Y} | Visited});
        true ->
            can_escape(Maze, {X, Y - 1}, Exit, [{X, Y} | Visited])
    end.