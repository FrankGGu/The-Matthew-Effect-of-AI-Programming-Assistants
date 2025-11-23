-module(solution).
-export([minimumSum/1]).

minimumSum(Nums) ->
    N = length(Nums),
    MinSum = find_min_sum(Nums, N, 0, N - 3, float:infinity()),
    case MinSum of
        X when X == float:infinity() -> -1;
        _ -> erlang:trunc(MinSum)
    end.

find_min_sum(Nums, N, I, MaxI, CurrentMinSum) when I =< MaxI ->
    NumI = lists:nth(I + 1, Nums),
    MinSumAfterJ = find_min_sum_j(Nums, N, I, NumI, I + 1, N - 2, CurrentMinSum),
    find_min_sum(Nums, N, I + 1, MaxI, MinSumAfterJ);
find_min_sum(_Nums, _N, _I, _MaxI, CurrentMinSum) ->
    CurrentMinSum.

find_min_sum_j(Nums, N, I, NumI, J, MaxJ, CurrentMinSum) when J =< MaxJ ->
    NumJ = lists:nth(J + 1, Nums),
    MinSumAfterK = find_min_sum_k(Nums, N, I, NumI, J, NumJ, J + 1, N - 1, CurrentMinSum),
    find_min_sum_j(Nums, N, I, NumI, J + 1, MaxJ, MinSumAfterK);
find_min_sum_j(_Nums, _N, _I, _NumI, _J, _MaxJ, CurrentMinSum) ->
    CurrentMinSum.

find_min_sum_k(Nums, _N, _I, NumI, _J, NumJ, K, MaxK, CurrentMinSum) when K =< MaxK ->
    NumK = lists:nth(K + 1, Nums),
    NewMinSum =
        if
            NumI < NumJ andalso NumK < NumJ ->
                min(CurrentMinSum, float(NumI + NumJ + NumK));
            true ->
                CurrentMinSum
        end,
    find_min_sum_k(Nums, _N, _I, NumI, _J, NumJ, K + 1, MaxK, NewMinSum);
find_min_sum_k(_Nums, _N, _I, _NumI, _J, _NumJ, _K, _MaxK, CurrentMinSum) ->
    CurrentMinSum.