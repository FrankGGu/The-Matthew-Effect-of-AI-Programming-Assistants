-module(solution).
-export([sum_k_subarrays/3]).

sum_k_subarrays(Nums, K, M) ->
    Prefix = prefix_sum(Nums),
    N = length(Nums),
    DP = array:new([{size, N + 1}, {default, 0}]),
    DP1 = array:set(0, 0, DP),
    {DP2, _} = lists:foldl(fun(I, {D, _}) ->
        Sum = if I >= M -> array:get(I - M, Prefix) - array:get(I - M - M + 1, Prefix); true -> 0 end,
        NewVal = if I >= M -> max(array:get(I - 1, D), Sum); true -> array:get(I - 1, D) end,
        {array:set(I, NewVal, D), I}
    end, {DP1, 0}, lists:seq(1, N)),
    lists:sum([array:get(I, DP2) || I <- lists:seq(K * M, N)]).

prefix_sum(Nums) ->
    lists:foldl(fun(X, {Sum, Arr}) ->
        NewSum = Sum + X,
        {NewSum, array:set(length(Arr), NewSum, Arr)}
    end, {0, array:new([{size, length(Nums) + 1}, {default, 0}])}, [0 | Nums]).