-module(solution).
-export([k_items_with_max_sum/3]).

k_items_with_max_sum(_K, _N, _M) ->
    k_items_with_max_sum(0, 0, _K, _N, _M).

k_items_with_max_sum(Sum, Index, 0, _N, _M) ->
    Sum;
k_items_with_max_sum(Sum, Index, K, N, M) when Index < N ->
    k_items_with_max_sum(Sum + Index, Index + 1, K - 1, N, M);
k_items_with_max_sum(Sum, Index, K, N, M) when Index < M ->
    k_items_with_max_sum(Sum + Index, Index + 1, K - 1, N, M);
k_items_with_max_sum(Sum, Index, K, N, M) ->
    k_items_with_max_sum(Sum + Index, Index + 1, K - 1, N, M).