-module(path_with_maximum_gold).
-export([getMaximumGold/1]).

getMaximumGold(Grid) ->
    Rows = length(Grid),
    if
        Rows == 0 -> 0;
        true ->
            Cols = length(hd(Grid)),
            MaxGold = 0,
            lists:foreach(fun(Row) ->
                lists:foreach(fun(Col) ->
                    if
                        element(Row+1, element(Col+1, Grid)) == 0 -> ok;
                        true ->
                            Gold = dfs(Grid, Row, Col, Rows, Cols, 0),
                            if
                                Gold > MaxGold -> erlang:put(max_gold, Gold);
                                true -> ok
                            end
                    end
                end, lists:seq(0, Cols-1))
            end, lists:seq(0, Rows-1)),
            erlang:get(max_gold)
    end.

dfs(Grid, Row, Col, Rows, Cols, Current) ->
    Cell = element(Row+1, element(Col+1, Grid)),
    if
        Cell == 0 -> Current;
        true ->
            Temp = Cell,
            NewGrid = set_cell(Grid, Row, Col, 0),
            Directions = [{-1,0}, {1,0}, {0,-1}, {0,1}],
            Max = lists:foldl(fun({DR, DC}, Acc) ->
                NewRow = Row + DR,
                NewCol = Col + DC,
                if
                    NewRow >= 0 andalso NewRow < Rows andalso NewCol >= 0 andalso NewCol < Cols ->
                        Next = dfs(NewGrid, NewRow, NewCol, Rows, Cols, Current + Temp),
                        if
                            Next > Acc -> Next;
                            true -> Acc
                        end;
                    true -> Acc
                end
            end, 0, Directions),
            set_cell(Grid, Row, Col, Temp),
            Current + Temp + Max
    end.

set_cell(Grid, Row, Col, Value) ->
    List = lists:map(fun(R) ->
        if
            R == Row -> lists:sublist(Grid, Col) ++ [Value] ++ lists:sublist(Grid, Col+1, length(Grid) - Col - 1);
            true -> lists:copy(Grid, R)
        end
    end, lists:seq(0, length(Grid)-1)),
    List.