-module(solution).
-export([countPairs/2]).

countPairs(Nums, K) ->
    N = length(Nums),
    count_pairs_loop_i(Nums, K, N, 0, 0).

count_pairs_loop_i(_Nums, _K, N, I, Acc) when I >= N ->
    Acc;
count_pairs_loop_i(Nums, K, N, I, Acc) ->
    Acc_with_j_pairs = count_pairs_loop_j(Nums, K, N, I, I + 1, Acc),
    count_pairs_loop_i(Nums, K, N, I + 1, Acc_with_j_pairs).

count_pairs_loop_j(_Nums, _K, N, _I, J, Acc) when J >= N ->
    Acc;
count_pairs_loop_j(Nums, K, N, I, J, Acc) ->
    NumI = lists:nth(I + 1, Nums),
    NumJ = lists:nth(J + 1, Nums),
    NewAcc = if
        NumI == NumJ andalso (I * J) rem K == 0 -> Acc + 1;
        true -> Acc
    end,
    count_pairs_loop_j(Nums, K, N, I, J + 1, NewAcc).