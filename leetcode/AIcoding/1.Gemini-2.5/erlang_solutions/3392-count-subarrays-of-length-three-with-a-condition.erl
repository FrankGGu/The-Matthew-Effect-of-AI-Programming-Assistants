-module(solution).
-export([count_subarrays/2]).

count_subarrays(Nums, K) ->
    count_subarrays_recursive(Nums, K, 0).

count_subarrays_recursive([A, B, C | Rest], K, Count) ->
    NewCount = if (A rem K == 0) andalso (B rem K == 0) andalso (C rem K == 0) ->
                   Count + 1;
                 true ->
                   Count
             end,
    count_subarrays_recursive([B, C | Rest], K, NewCount);
count_subarrays_recursive(_, _, Count) ->
    Count.