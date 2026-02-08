-module(longest_increasing_path).
-export([longest_increasing_path/1]).

longest_increasing_path(Matrix) ->
    Rows = length(Matrix),
    if
        Rows == 0 -> 0;
        true ->
            Cols = length(hd(Matrix)),
            DP = array:new({1, Rows}, {1, Cols}, 0),
            Max = 0,
            lists:foreach(fun(Row) ->
                                lists:foreach(fun(Col) ->
                                                    Max = max(Max, dfs(Matrix, Row, Col, DP))
                                                end, lists:seq(0, Cols-1))
                            end, lists:seq(0, Rows-1)),
            Max
    end.

dfs(Matrix, Row, Col, DP) ->
    case array:get({Row+1, Col+1}, DP) of
        Val when Val > 0 -> Val;
        _ ->
            Directions = [{-1,0}, {1,0}, {0,-1}, {0,1}],
            MaxLen = 0,
            lists:foreach(fun({DR, DC}) ->
                                NewRow = Row + DR,
                                NewCol = Col + DC,
                                if
                                    NewRow >= 0, NewRow < length(Matrix), NewCol >= 0, NewCol < length(hd(Matrix)) ->
                                        if
                                            element(NewRow+1, Matrix) > element(Row+1, Matrix) ->
                                                Len = dfs(Matrix, NewRow, NewCol, DP),
                                                MaxLen = max(MaxLen, Len);
                                            true -> ok
                                        end;
                                    true -> ok
                                end
                            end, Directions),
            array:set({Row+1, Col+1}, MaxLen + 1, DP)
    end.