-module(solution).
-export([count_sub_islands/2]).

count_sub_islands(Grid1, Grid2) ->
    Rows = length(Grid1),
    Cols = length(hd(Grid1)),
    Grid2Filtered = lists:map(fun(Row) -> lists:map(fun(X) -> if X =:= 1 -> 1; true -> 0 end) end(Row) end, Grid2),
    Grid1Filtered = lists:map(fun(Row) -> lists:map(fun(X) -> if X =:= 1 -> 1; true -> 0 end) end(Row) end, Grid1),
    count_sub(Grid1Filtered, Grid2Filtered, Rows, Cols).

count_sub(Grid1, Grid2, Rows, Cols) ->
    lists:foldl(fun({R, C}, Acc) -> 
        case (Grid1:R,C) of 
            1 -> 
                if 
                    (Grid2:R,C) =:= 1 -> 
                        Acc + 1 
                    ; 
                    true -> 
                        Acc 
                end
            ; 
            _ -> Acc 
        end 
    end, 0, [{R, C} || R <- lists:seq(1, Rows), C <- lists:seq(1, Cols), (Grid1:R,C) =:= 1]).