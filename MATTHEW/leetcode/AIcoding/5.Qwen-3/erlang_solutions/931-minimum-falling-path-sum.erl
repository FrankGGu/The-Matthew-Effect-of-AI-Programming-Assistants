-module(minimum_falling_path_sum).
-export([minFallingPathSum/1]).

minFalling_path_sum(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    DP = array:new({0, Rows-1}, {default, array:new({0, Cols-1}, {default, 0})}),
    init_dp(DP, Matrix, 0),
    min_row(DP, Rows-1).

init_dp(DP, Matrix, 0) ->
    Row = hd(Matrix),
    Cols = length(Row),
    lists:foreach(fun(Col) -> array:set({0, Col}, lists:nth(Col+1, Row), DP) end, lists:seq(0, Cols-1)),
    init_dp(DP, tl(Matrix), 1);
init_dp(DP, [], _) ->
    ok;
init_dp(DP, [Row | Rest], RowIdx) ->
    Cols = length(Row),
    lists:foreach(fun(Col) ->
        MinPrev = min_prev(DP, RowIdx-1, Col),
        array:set({RowIdx, Col}, lists:nth(Col+1, Row) + MinPrev, DP)
    end, lists:seq(0, Cols-1)),
    init_dp(DP, Rest, RowIdx+1).

min_prev(DP, Row, Col) ->
    Min = lists:min([
        array:get({Row, Col-1}, DP) when Col > 0,
        array:get({Row, Col}, DP),
        array:get({Row, Col+1}, DP) when Col < (length(array:to_list(array:get({Row, 0}, DP))) - 1)
    ]),
    Min.

min_row(DP, Row) ->
    Cols = length(array:to_list(array:get({Row, 0}, DP))),
    lists:min([array:get({Row, Col}, DP) || Col <- lists:seq(0, Cols-1)]).

minFallingPathSum(Matrix) ->
    min_falling_path_sum(Matrix).