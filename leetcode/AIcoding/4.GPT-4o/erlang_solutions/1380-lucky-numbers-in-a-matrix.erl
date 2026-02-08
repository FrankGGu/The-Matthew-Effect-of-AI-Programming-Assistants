-module(solution).
-export([lucky_numbers/1]).

lucky_numbers(Matrix) ->
    Rows = length(Matrix),
    Cols = case Rows of
                0 -> 0;
                _ -> length(hd(Matrix))
            end,
    RowMins = [lists:min(Row) || Row <- Matrix],
    ColMaxs = [lists:max([Matrix[Row][Col] || Row <- lists:seq(1, Rows)]) || Col <- lists:seq(1, Cols)],
    [Matrix[Row][Col] || Row <- lists:seq(1, Rows), Col <- lists:seq(1, Cols), 
     Matrix[Row][Col] =:= RowMins[Row-1], 
     Matrix[Row][Col] =:= ColMaxs[Col-1]].