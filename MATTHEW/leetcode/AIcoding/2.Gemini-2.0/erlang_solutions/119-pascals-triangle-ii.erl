-module(pascals_triangle_ii).
-export([get_row/1]).

get_row(0) -> [1];
get_row(RowIndex) ->
    PrevRow = get_row(RowIndex - 1),
    lists:seq(1, RowIndex + 1, fun(I) -> 
        case I of
            1 -> 1;
            RowIndex + 1 -> 1;
            _ -> 
                lists:nth(I - 1, PrevRow) + lists:nth(I, PrevRow)
        end
    end).