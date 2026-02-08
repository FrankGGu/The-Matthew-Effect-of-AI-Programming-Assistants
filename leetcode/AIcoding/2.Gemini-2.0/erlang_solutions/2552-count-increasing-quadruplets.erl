-module(count_increasing_quadruplets).
-export([count_quadruplets/1]).

count_quadruplets(Nums) ->
    N = length(Nums),
    count_quadruplets_helper(Nums, N, 0).

count_quadruplets_helper(_Nums, N, Acc) when N < 4 ->
    Acc;
count_quadruplets_helper(Nums, N, Acc) ->
    count_quadruplets_helper(Nums, N - 1, Acc + count_quadruplets_for_last(Nums, N)).

count_quadruplets_for_last(Nums, N) ->
    count_quadruplets_for_last_helper(Nums, N, 1, 0).

count_quadruplets_for_last_helper(_Nums, N, J, Acc) when J >= N - 1 ->
    Acc;
count_quadruplets_for_last_helper(Nums, N, J, Acc) ->
    if
        lists:nth(J, Nums) > lists:nth(N, Nums) ->
            Acc1 = Acc + count_pairs_before(Nums, J, N);
        true ->
            Acc1 = Acc
    end,
    count_quadruplets_for_last_helper(Nums, N, J + 1, Acc1).

count_pairs_before(Nums, J, N) ->
    count_pairs_before_helper(Nums, 1, J, lists:nth(N, Nums), lists:nth(J, Nums), 0).

count_pairs_before_helper(_Nums, I, J, Last, Current, Acc) when I >= J ->
    Acc;
count_pairs_before_helper(Nums, I, J, Last, Current, Acc) ->
    if
        lists:nth(I, Nums) < Current and lists:nth(I, Nums) > Last ->
            count_pairs_before_helper(Nums, I + 1, J, Last, Current, Acc);
        lists:nth(I, Nums) < Current ->
            count_pairs_before_helper(Nums, I + 1, J, Last, Current, Acc + 1);
        true ->
            count_pairs_before_helper(Nums, I + 1, J, Last, Current, Acc)
    end.