-module(solution).
-export([has_path/1]).

has_path(Maze) ->
    Start = find_pos(Maze, $S),
    End = find_pos(Maze, $E),
    Visited = sets:new(),
    dfs(Maze, Start, End, Visited).

find_pos(Maze, Char) ->
    {Rows, _} = lists:splitwith(fun(Row) -> not lists:member(Char, Row) end, Maze),
    RowIndex = length(Rows),
    ColIndex = string:chr(lists:nth(RowIndex + 1, Maze), Char) - 1,
    {RowIndex, ColIndex}.

dfs(Maze, {X, Y}, End, Visited) ->
    case {X, Y} == End of
        true -> true;
        false ->
            case sets:is_element({X, Y}, Visited) of
                true -> false;
                false ->
                    NewVisited = sets:add_element({X, Y}, Visited),
                    Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
                    lists:any(fun({Dx, Dy}) ->
                        NX = X + Dx,
                        NY = Y + Dy,
                        is_valid(Maze, NX, NY) andalso dfs(Maze, {NX, NY}, End, NewVisited)
                    end, Directions)
            end
    end.

is_valid(Maze, X, Y) ->
    Rows = length(Maze),
    (X >= 1) andalso (X =< Rows) andalso
    begin
        Row = lists:nth(X, Maze),
        Cols = length(Row),
        (Y >= 1) andalso (Y =< Cols) andalso (lists:nth(Y, Row) =/= $#)
    end.