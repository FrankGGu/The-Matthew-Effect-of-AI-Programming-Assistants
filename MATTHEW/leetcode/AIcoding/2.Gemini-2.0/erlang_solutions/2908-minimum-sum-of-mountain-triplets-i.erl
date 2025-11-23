-module(minimum_sum_mountain_triplets_i).
-export([minimum_sum/1]).

minimum_sum(Nums) ->
    N = length(Nums),
    minimum_sum(Nums, N, infinity).

minimum_sum(_Nums, 0, Acc) ->
    if Acc == infinity then
        -1
    else
        Acc
    end;
minimum_sum(Nums, N, Acc) ->
    minimum_sum(Nums, N, 0, Acc).

minimum_sum(Nums, N, I, Acc) ->
    if I >= N - 2 then
        minimum_sum(Nums, N - 1, Acc)
    else
        minimum_sum(Nums, N, I, I + 1, Acc).

minimum_sum(Nums, N, I, J, Acc) ->
    if J >= N - 1 then
        minimum_sum(Nums, N, I + 1, Acc)
    else
        minimum_sum(Nums, N, I, J, J + 1, Acc).

minimum_sum(Nums, N, I, J, K, Acc) ->
    if K >= N then
        minimum_sum(Nums, N, I, J + 1, Acc)
    else
        if lists:nth(I + 1, Nums) < lists:nth(J + 1, Nums) andalso lists:nth(J + 1, Nums) > lists:nth(K + 1, Nums) then
            Sum = lists:nth(I + 1, Nums) + lists:nth(J + 1, Nums) + lists:nth(K + 1, Nums),
            NewAcc = min(Acc, Sum),
            minimum_sum(Nums, N, I, J, K + 1, NewAcc)
        else
            minimum_sum(Nums, N, I, J, K + 1, Acc)
        end.