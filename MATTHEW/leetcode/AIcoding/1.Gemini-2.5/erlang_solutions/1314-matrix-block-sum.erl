-module(solution).
-export([matrixBlockSum/2]).

matrixBlockSum(Mat, K) ->
    M = length(Mat),
    N = length(hd(Mat)),

    PrefixSum = build_prefix_sum(Mat, M, N),

    [ [ get_block_sum(PrefixSum, max(0, I-K), max(0, J-K), min(M-1, I+K), min(N-1, J+K))
      || J <- lists:seq(0, N-1) ]
    || I <- lists:seq(0, M-1) ].

build_prefix_sum(Mat, M, N) ->
    ZerosRow = lists:duplicate(N+1, 0),
    lists:reverse(build_prefix_sum_rows_optimized(Mat, ZerosRow, [ZerosRow])).

build_prefix_sum_rows_optimized([], _PrevPrefixSumRow, AccPrefixSumMatrix) ->
    AccPrefixSumMatrix;
build_prefix_sum_rows_optimized([MatH|MatT], PrevPrefixSumRow, AccPrefixSumMatrix) ->
    CurrentPrefixSumRow = build_prefix_sum_cols_optimized(MatH, PrevPrefixSumRow, 0, [0]),
    build_prefix_sum_rows_optimized(MatT, CurrentPrefixSumRow, [CurrentPrefixSumRow | AccPrefixSumMatrix]).

build_prefix_sum_cols_optimized([], [_PrevPSH|_PrevPST], _PrevColVal, AccCurrentRow) ->
    lists:reverse(AccCurrentRow);
build_prefix_sum_cols_optimized([MatH|MatT], [PrevPSH|PrevPST], PrevColVal, AccCurrentRow) ->
    P_up = hd(PrevPST),
    P_diag = PrevPSH,

    NewPVal = MatH + P_up + PrevColVal - P_diag,

    build_prefix_sum_cols_optimized(MatT, PrevPST, NewPVal, [NewPVal | AccCurrentRow]).

get_block_sum(PrefixSum, R1, C1, R2, C2) ->
    Val_R2C2 = lists:nth(C2+1+1, lists:nth(R2+1+1, PrefixSum)),
    Val_R1m1C2 = lists:nth(C2+1+1, lists:nth(R1+1, PrefixSum)),
    Val_R2C1m1 = lists:nth(C1+1, lists:nth(R2+1+1, PrefixSum)),
    Val_R1m1C1m1 = lists:nth(C1+1, lists:nth(R1+1, PrefixSum)),

    Val_R2C2 - Val_R1m1C2 - Val_R2C1m1 + Val_R1m1C1m1.