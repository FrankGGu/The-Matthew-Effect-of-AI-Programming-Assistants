-module(solution).
-export([max_area/1]).

max_area(Grid) ->
    MaxArea = lists:foldl(fun(Row, Acc) -> 
        lists:foldl(fun(Cell, Acc1) -> 
            case Cell of 
                1 -> 
                    Area = dfs(Grid, Row, Acc1),
                    max(Area, Acc1);
                _ -> 
                    Acc1
            end
        end, Acc, Row)
    end, 0, lists:seq(0, length(Grid) - 1)),
    MaxArea.

dfs(Grid, Row, Col) ->
    if
        Row < 0 orelse Row >= length(Grid) orelse Col < 0 orelse Col >= length(hd(Grid)) orelse lists:nth(Row + 1, Grid) =:= [] orelse lists:nth(Col + 1, lists:nth(Row + 1, Grid)) =:= 0 ->
            0;
        true ->
            Grid1 = lists:replace(Row + 1, lists:replace(Col + 1, 0, lists:nth(Row + 1, Grid)), Grid),
            1 + dfs(Grid1, Row - 1, Col) + dfs(Grid1, Row + 1, Col) + dfs(Grid1, Row, Col - 1) + dfs(Grid1, Row, Col + 1)
    end.