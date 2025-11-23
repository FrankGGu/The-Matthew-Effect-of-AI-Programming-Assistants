-module(partition_k_equal_sum_subsets).
-export([can_partition_k_subsets/2]).

can_partition_k_subsets(Nums, K) ->
    Sum = lists:sum(Nums),
    if Sum rem K /= 0 then
        false
    else
        Target = Sum div K,
        N = length(Nums),
        Visited = sets:new(),
        can_partition_k_subsets_helper(Nums, K, Target, 0, 0, Visited, N)
    end.

can_partition_k_subsets_helper(_Nums, 0, _Target, _CurrSum, _StartIndex, _Visited, _N) ->
    true;
can_partition_k_subsets_helper(Nums, K, Target, CurrSum, StartIndex, Visited, N) ->
    if CurrSum == Target then
        can_partition_k_subsets_helper(Nums, K - 1, Target, 0, 0, Visited, N)
    else
        lists:any(fun(I) ->
                          not sets:is_element(I, Visited) andalso
                              CurrSum + lists:nth(I + 1, Nums) =< Target andalso
                              sets:is_empty(sets:add_element(I, Visited)) andalso
                              can_partition_k_subsets_helper(Nums, K, Target, CurrSum + lists:nth(I + 1, Nums), I + 1, sets:add_element(I, Visited), N)
                  end, lists:seq(StartIndex, N - 1))
    end.