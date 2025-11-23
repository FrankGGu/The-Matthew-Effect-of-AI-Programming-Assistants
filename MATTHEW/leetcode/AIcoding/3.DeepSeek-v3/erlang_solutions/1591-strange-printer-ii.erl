-module(solution).
-export([isPrintable/1]).

isPrintable(TargetGrid) ->
    M = length(TargetGrid),
    N = length(hd(TargetGrid)),
    Colors = lists:usort(lists:flatten(TargetGrid)),
    lists:all(fun(Color) -> check_color(Color, TargetGrid, M, N) end, Colors).

check_color(Color, Grid, M, N) ->
    {MinI, MaxI, MinJ, MaxJ} = find_bounds(Color, Grid, M, N, M, 0, N, 0),
    check_rect(Color, Grid, MinI, MaxI, MinJ, MaxJ).

find_bounds(Color, Grid, I, J, MinI, MaxI, MinJ, MaxJ) when I >= 1 ->
    Row = lists:nth(I, Grid),
    case lists:nth(J, Row) of
        Color ->
            NewMinI = min(I, MinI),
            NewMaxI = max(I, MaxI),
            NewMinJ = min(J, MinJ),
            NewMaxJ = max(J, MaxJ),
            find_bounds(Color, Grid, I, J - 1, NewMinI, NewMaxI, NewMinJ, NewMaxJ);
        _ ->
            find_bounds(Color, Grid, I, J - 1, MinI, MaxI, MinJ, MaxJ)
    end;
find_bounds(Color, Grid, I, 0, MinI, MaxI, MinJ, MaxJ) when I > 1 ->
    find_bounds(Color, Grid, I - 1, N, MinI, MaxI, MinJ, MaxJ);
find_bounds(_, _, 0, _, MinI, MaxI, MinJ, MaxJ) ->
    {MinI, MaxI, MinJ, MaxJ}.

check_rect(Color, Grid, MinI, MaxI, MinJ, MaxJ) ->
    lists:all(fun(I) ->
        lists:all(fun(J) ->
            Pixel = lists:nth(I, Grid),
            lists:nth(J, Pixel) == Color orelse lists:nth(I, Grid),
            lists:nth(J, Pixel) == 0
        end, lists:seq(MinJ, MaxJ))
    end, lists:seq(MinI, MaxI)).