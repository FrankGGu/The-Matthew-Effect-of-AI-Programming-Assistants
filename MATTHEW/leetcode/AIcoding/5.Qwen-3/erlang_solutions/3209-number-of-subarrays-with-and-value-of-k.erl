-module(solution).
-export([num_subarrays/2]).

num_subarrays(Nums, K) ->
    len(Nums, K, 0, 0, 0).

len([], _, _, _, Acc) -> Acc;
len([H|T], K, CurrentAnd, Count, Acc) ->
    CurrentAnd1 = if
        CurrentAnd == 0 -> H;
        true -> CurrentAnd band H
    end,
    Count1 = if
        CurrentAnd1 == K -> Count + 1;
        true -> Count
    end,
    len(T, K, CurrentAnd1, Count1, Acc + Count1).