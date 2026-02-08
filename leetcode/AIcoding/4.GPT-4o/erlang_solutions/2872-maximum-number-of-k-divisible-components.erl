-module(solution).
-export([max_k_divisible_components/2]).

max_k_divisible_components(N, K) when N > 0, K > 0 ->
    max_k_divisible_components(N, K, 0, 1).

max_k_divisible_components(N, K, Count, Current) when Current > N ->
    Count;
max_k_divisible_components(N, K, Count, Current) ->
    NewCount = if
        Current rem K =:= 0 -> Count + 1;
        true -> Count
    end,
    max_k_divisible_components(N, K, NewCount, Current + 1).