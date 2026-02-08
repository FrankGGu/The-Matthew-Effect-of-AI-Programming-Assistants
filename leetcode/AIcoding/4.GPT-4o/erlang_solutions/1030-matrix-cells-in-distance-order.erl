-module(solution).
-export([all_cells_dist_order/3]).

all_cells_dist_order(Rows, Cols, r0, c0) ->
    Cells = lists:seq(0, Rows - 1),
    lists:flatmap(fun(R) -> lists:map(fun(C) -> {R, C} end, lists:seq(0, Cols - 1)) end, Cells)
    |> lists:sort(fun({R1, C1}, {R2, C2}) -> 
        case abs(R1 - R0) + abs(C1 - C0) <=> abs(R2 - R0) + abs(C2 - C0) of
            < -> true;
            > -> false;
            _ -> R1 < R2 orelse (R1 =:= R2 andalso C1 < C2)
        end
    end).