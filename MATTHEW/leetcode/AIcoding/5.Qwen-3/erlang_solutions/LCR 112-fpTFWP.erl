-module(longest_increasing_path).
-export([longest_increasing_path/1]).

longest_increasing_path(Matrix) ->
    Rows = length(Matrix),
    if
        Rows == 0 -> 0;
        true ->
            Cols = length(hd(Matrix)),
            Visited = array:new({0, Rows-1}, {default, array:new({0, Cols-1}, {default, 0})}),
            DP = array:new({0, Rows-1}, {default, array:new({0, Cols-1}, {default, 0})}),
            MaxPath = 0,
            lists:foreach(fun(Row) ->
                lists:foreach(fun(Col) ->
                    Path = dfs(Matrix, Row, Col, Visited, DP),
                    if
                        Path > MaxPath -> MaxPath = Path;
                        true -> ok
                    end
                end, lists:seq(0, Cols-1))
            end, lists:seq(0, Rows-1)),
            MaxPath
    end.

dfs(Matrix, Row, Col, Visited, DP) ->
    case array:get({Row, Col}, DP) of
        0 ->
            case array:get({Row, Col}, Visited) of
                1 -> 0;
                _ ->
                    array:set({Row, Col}, 1, Visited),
                    Directions = [{-1,0}, {1,0}, {0,-1}, {0,1}],
                    MaxLen = lists:foldl(fun({DR, DC}, Acc) ->
                        NewRow = Row + DR,
                        NewCol = Col + DC,
                        if
                            NewRow >= 0, NewRow < length(Matrix), NewCol >= 0, NewCol < length(hd(Matrix)) ->
                                if
                                    lists:nth(NewRow+1, Matrix) -- lists:nth(Col+1, hd(Matrix)) > 0 ->
                                        Len = dfs(Matrix, NewRow, NewCol, Visited, DP),
                                        max(Acc, Len + 1);
                                    true -> Acc
                                end;
                            true -> Acc
                        end
                    end, 1, Directions),
                    array:set({Row, Col}, MaxLen, DP),
                    MaxLen;
                _ -> 0
            end;
        Val -> Val
    end.