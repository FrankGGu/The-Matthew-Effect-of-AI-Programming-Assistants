-module(maximum_minimum_sums).
-export([max_min_sums/2]).

max_min_sums(Nums, K) ->
    N = length(Nums),
    Sums = [],
    max_min_sums_helper(Nums, K, 0, N - 1, Sums).

max_min_sums_helper(_Nums, 0, _, _, Sums) ->
    lists:sort(Sums);
max_min_sums_helper(Nums, K, Start, End, Sums) ->
    case Start > End of
        true ->
            Sums;
        false ->
            NewSums1 = max_min_sums_helper(Nums, K, Start + 1, End, Sums),
            NewSums2 =
                case K > 1 of
                    true ->
                        max_min_sums_helper(Nums, K - 1, Start + 1, End, [lists:sum([lists:nth(Start + 1 + I, Nums) || I <- lists:seq(0, K - 2)]) + lists:nth(Start + 1 - 1, Nums) | NewSums1]);
                    false ->
                        [lists:nth(Start + 1 - 1, Nums) | NewSums1]
                end,
            NewSums2
    end.