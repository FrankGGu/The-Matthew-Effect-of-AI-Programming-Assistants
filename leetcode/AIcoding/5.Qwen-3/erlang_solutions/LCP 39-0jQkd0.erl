-module(quadcopter_matrix).
-export([numEnclaves/1]).

numEnclaves(Board) ->
    Rows = length(Board),
    if
        Rows == 0 -> 0;
        true ->
            Cols = length(hd(Board)),
            Visited = array:new({0, Rows-1}, {default, array:new({0, Cols-1}, {default, false})}),
            doDfs(Board, Visited, Rows, Cols)
    end.

doDfs(Board, Visited, Rows, Cols) ->
    Count = 0,
    I = 0,
    doDfsRow(Board, Visited, Rows, Cols, I, Count).

doDfsRow(_, _, Rows, _, I, Count) when I >= Rows -> Count;
doDfsRow(Board, Visited, Rows, Cols, I, Count) ->
    J = 0,
    doDfsCol(Board, Visited, Rows, Cols, I, J, Count).

doDfsCol(_, _, _, Cols, I, J, Count) when J >= Cols -> Count;
doDfsCol(Board, Visited, Rows, Cols, I, J, Count) ->
    Cell = lists:nth(I+1, Board),
    Value = lists:nth(J+1, Cell),
    case Value of
        1 ->
            case array:get({I, J}, Visited) of
                false ->
                    NewVisited = dfs(Board, Visited, I, J, Rows, Cols),
                    doDfsRow(Board, NewVisited, Rows, Cols, I, Count);
                _ ->
                    doDfsCol(Board, Visited, Rows, Cols, I, J+1, Count)
            end;
        _ ->
            doDfsCol(Board, Visited, Rows, Cols, I, J+1, Count)
    end.

dfs(_, Visited, I, J, Rows, Cols) when I < 0; I >= Rows; J < 0; J >= Cols -> Visited;
dfs(Board, Visited, I, J, Rows, Cols) ->
    case array:get({I, J}, Visited) of
        true -> Visited;
        _ ->
            NewVisited = array:set({I, J}, true, Visited),
            dfs(Board, NewVisited, I-1, J, Rows, Cols),
            dfs(Board, NewVisited, I+1, J, Rows, Cols),
            dfs(Board, NewVisited, I, J-1, Rows, Cols),
            dfs(Board, NewVisited, I, J+1, Rows, Cols)
    end.

countUnvisited(Board, Visited, Rows, Cols) ->
    Count = 0,
    I = 0,
    countUnvisitedRow(Board, Visited, Rows, Cols, I, Count).

countUnvisitedRow(_, _, Rows, _, I, Count) when I >= Rows -> Count;
countUnvisitedRow(Board, Visited, Rows, Cols, I, Count) ->
    J = 0,
    countUnvisitedCol(Board, Visited, Rows, Cols, I, J, Count).

countUnvisitedCol(_, _, _, Cols, I, J, Count) when J >= Cols -> Count;
countUnvisitedCol(Board, Visited, Rows, Cols, I, J, Count) ->
    Cell = lists:nth(I+1, Board),
    Value = lists:nth(J+1, Cell),
    case Value of
        1 ->
            case array:get({I, J}, Visited) of
                false -> countUnvisitedCol(Board, Visited, Rows, Cols, I, J+1, Count + 1);
                _ -> countUnvisitedCol(Board, Visited, Rows, Cols, I, J+1, Count)
            end;
        _ -> countUnvisitedCol(Board, Visited, Rows, Cols, I, J+1, Count)
    end.