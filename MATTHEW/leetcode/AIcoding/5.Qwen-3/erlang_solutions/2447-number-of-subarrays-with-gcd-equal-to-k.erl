-module(solution).
-export([num_subarrays/2]).

num_subarrays(Nums, K) ->
    lists:foldl(fun(N, Acc) -> count_subarrays(Nums, N, K, Acc) end, 0, lists:seq(1, length(Nums))).

count_subarrays([], _, _, Acc) -> Acc;
count_subarrays([H|T], Index, K, Acc) ->
    Current = H,
    if
        Current == K -> count_subarrays(T, Index + 1, K, Acc + 1);
        true -> count_subarrays(T, Index + 1, K, Acc)
    end.