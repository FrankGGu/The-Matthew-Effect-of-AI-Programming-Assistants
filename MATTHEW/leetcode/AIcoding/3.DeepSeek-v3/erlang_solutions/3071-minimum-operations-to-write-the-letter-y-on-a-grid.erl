-module(solution).
-export([minimum_operations_to_write_y/1]).

minimum_operations_to_write_y(Grid) ->
    N = length(Grid),
    Half = N div 2,
    YCells = get_y_cells(N, Half),
    OtherCells = get_other_cells(N, Half),
    CountsY = count_values(Grid, YCells),
    CountsOther = count_values(Grid, OtherCells),
    MinOps = find_min_operations(CountsY, CountsOther),
    MinOps.

get_y_cells(N, Half) ->
    YCells = [],
    get_y_cells(0, N, Half, YCells).

get_y_cells(I, N, _Half, Acc) when I >= N ->
    Acc;
get_y_cells(I, N, Half, Acc) when I < Half ->
    NewAcc = [{I, I} | [{I, N - 1 - I} | Acc]],
    get_y_cells(I + 1, N, Half, NewAcc);
get_y_cells(I, N, Half, Acc) ->
    NewAcc = [{I, Half} | Acc],
    get_y_cells(I + 1, N, Half, NewAcc).

get_other_cells(N, Half) ->
    AllCells = [{X, Y} || X <- lists:seq(0, N - 1), Y <- lists:seq(0, N - 1)],
    YCells = get_y_cells(N, Half),
    lists:subtract(AllCells, YCells).

count_values(Grid, Cells) ->
    Counts = #{0 => 0, 1 => 0, 2 => 0},
    count_values(Grid, Cells, Counts).

count_values(_Grid, [], Counts) ->
    Counts;
count_values(Grid, [{X, Y} | Rest], Counts) ->
    Row = lists:nth(X + 1, Grid),
    Val = lists:nth(Y + 1, Row),
    NewCounts = maps:update_with(Val, fun(V) -> V + 1 end, Counts),
    count_values(Grid, Rest, NewCounts).

find_min_operations(CountsY, CountsOther) ->
    Keys = [0, 1, 2],
    MinOps = lists:min([
        (maps:get(0, CountsY) + 
        lists:sum([maps:get(K, CountsOther) || K <- Keys, K /= 1]),
        (maps:get(1, CountsY) + 
        lists:sum([maps:get(K, CountsOther) || K <- Keys, K /= 0]),
        (maps:get(2, CountsY) + 
        lists:sum([maps:get(K, CountsOther) || K <- Keys, K /= 0])
    ]),
    MinOps.