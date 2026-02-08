-module(solution).
-export([is_possible/1]).

is_possible(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Dir = [{-1,0},{1,0},{0,-1},{0,1}],
    Visited = array:new({size,Rows}, {default, array:new({size,Cols}, {default, false})}),
    Count = 0,
    Loop(Rows, Cols, Grid, Dir, Visited, Count).

Loop(Rows, Cols, Grid, Dir, Visited, Count) when Rows > 0 ->
    Loop(Rows-1, Cols, Grid, Dir, Visited, Count);
Loop(0, Cols, Grid, Dir, Visited, Count) when Cols > 0 ->
    Loop(0, Cols-1, Grid, Dir, Visited, Count);
Loop(0, 0, Grid, Dir, Visited, Count) ->
    Count;
Loop(Row, Col, Grid, Dir, Visited, Count) ->
    Cell = lists:nth(Row+1, Grid),
    Value = lists:nth(Col+1, Cell),
    if
        Value == 1 andalso not array:get({Row,Col}, Visited) ->
            NewVisited = array:set({Row,Col}, true, Visited),
            dfs(Row, Col, Grid, Dir, NewVisited),
            Loop(Row, Col-1, Grid, Dir, NewVisited, Count+1);
        true ->
            Loop(Row, Col-1, Grid, Dir, Visited, Count)
    end.

dfs(Row, Col, Grid, Dir, Visited) ->
    lists:foreach(fun({DRow, DCol}) ->
        NewRow = Row + DRow,
        NewCol = Col + DCol,
        if
            NewRow >= 0 andalso NewRow < length(Grid) andalso
            NewCol >= 0 andalso NewCol < length(hd(Grid)) andalso
            lists:nth(NewRow+1, Grid) =:= 1 andalso
            not array:get({NewRow,NewCol}, Visited) ->
                NewVisited = array:set({NewRow,NewCol}, true, Visited),
                dfs(NewRow, NewCol, Grid, Dir, NewVisited);
            true ->
                ok
        end
    end, Dir).