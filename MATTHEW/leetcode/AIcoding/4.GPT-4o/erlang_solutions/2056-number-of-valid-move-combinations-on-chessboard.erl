-module(solution).
-export([number_of_combinations/2]).

number_of_combinations(N, K) when N > 0, K >= 0 ->
    lists:foldl(fun(_, Acc) -> Acc * (N - 1) div (K + 1) end, 1, lists:seq(1, K)).