-module(solution).
-export([maximumRows/2]).

maximumRows(Mat, NumSelect) ->
    N = length(hd(Mat)),
    MaxMask = (1 bsl N) - 1,
    find_max_rows(0, MaxMask, N, NumSelect, Mat, 0).

find_max_rows(CurrentMask, MaxMask, _N, _NumSelect, _Mat, MaxSoFar) when CurrentMask > MaxMask ->
    MaxSoFar;
find_max_rows(CurrentMask, MaxMask, N, NumSelect, Mat, MaxSoFar) ->
    PopCount = popcount(CurrentMask),
    NewMaxSoFar =
        if PopCount == NumSelect ->
            CurrentCoveredRows = count_covered_rows(Mat, CurrentMask),
            max(MaxSoFar, CurrentCoveredRows);
        true ->
            MaxSoFar
        end,
    find_max_rows(CurrentMask + 1, MaxMask, N, NumSelect, Mat, NewMaxSoFar).

popcount(N) -> popcount_acc(N, 0).
popcount_acc(0, Acc) -> Acc;
popcount_acc(N, Acc) ->
    popcount_acc(N bsr 1, Acc + (N band 1)).

count_covered_rows(Mat, Mask) ->
    count_covered_rows(Mat, Mask, 0).

count_covered_rows([], _Mask, Acc) -> Acc;
count_covered_rows([Row | Rest], Mask, Acc) ->
    if check_row_covered(Row, Mask) ->
        count_covered_rows(Rest, Mask, Acc + 1);
    true ->
        count_covered_rows(Rest, Mask, Acc)
    end.

check_row_covered(Row, Mask) ->
    check_row_covered(Row, Mask, 0).

check_row_covered([], _Mask, _ColIdx) -> true;
check_row_covered([Val | Rest], Mask, ColIdx) ->
    if
        Val == 1 ->
            ( (Mask bsr ColIdx) band 1 ) == 1 andalso check_row_covered(Rest, Mask, ColIdx + 1);
        true ->
            check_row_covered(Rest, Mask, ColIdx + 1)
    end.