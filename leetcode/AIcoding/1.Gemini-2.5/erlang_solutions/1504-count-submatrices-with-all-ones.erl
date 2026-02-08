-module(solution).
-export([count_submatrices/1]).

count_submatrices(Mat) ->
    Rows = length(Mat),
    Cols = if Rows > 0 -> length(hd(Mat));
              true -> 0
           end,

    InitialHeights = lists:duplicate(Cols, 0),
    count_rows(Mat, InitialHeights, 0).

count_rows([], _PrevHeights, AccTotal) ->
    AccTotal;
count_rows([CurrentRow | RestRows], PrevHeights, AccTotal) ->
    NewHeights = calculate_heights_for_row(CurrentRow, PrevHeights),
    RowCount = count_for_row(NewHeights),
    count_rows(RestRows, NewHeights, AccTotal + RowCount).

calculate_heights_for_row(CurrentRow, PrevHeights) ->
    calculate_heights_for_row(CurrentRow, PrevHeights, []).

calculate_heights_for_row([], [], AccHeights) ->
    lists:reverse(AccHeights);
calculate_heights_for_row([Val | RestCurrentRow], [PrevHeight | RestPrevHeights], AccHeights) ->
    CurrentHeight = if Val == 1 -> PrevHeight + 1;
                        true -> 0
                    end,
    calculate_heights_for_row(RestCurrentRow, RestPrevHeights, [CurrentHeight | AccHeights]).

count_for_row(Heights) ->
    Cols = length(Heights),
    count_for_row_loop_j(Heights, 0, Cols, 0).

count_for_row_loop_j(_Heights, J, Cols, AccTotal) when J >= Cols ->
    AccTotal;
count_for_row_loop_j(Heights, J, Cols, AccTotal) ->
    InitialMinHeight = lists:nth(J + 1, Heights),
    SubmatricesFromJ = count_for_row_loop_k(Heights, J, J, InitialMinHeight, 0),
    count_for_row_loop_j(Heights, J + 1, Cols, AccTotal + SubmatricesFromJ).

count_for_row_loop_k(_Heights, _J, K, _MinHeight, Acc) when K < 0 ->
    Acc;
count_for_row_loop_k(Heights, J, K, CurrentMinHeight, Acc) ->
    HeightAtK = lists:nth(K + 1, Heights),
    NewMinHeight = min(CurrentMinHeight, HeightAtK),
    count_for_row_loop_k(Heights, J, K - 1, NewMinHeight, Acc + NewMinHeight).