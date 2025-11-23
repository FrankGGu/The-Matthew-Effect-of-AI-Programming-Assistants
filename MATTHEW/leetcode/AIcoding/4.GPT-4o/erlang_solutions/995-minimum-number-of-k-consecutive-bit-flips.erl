-module(solution).
-export([min_k_bit_flips/2]).

min_k_bit_flips(Arr, K) ->
    N = length(Arr),
    Flips = lists:duplicate(N, 0),
    min_k_bit_flips(Arr, Flips, K, 0, 0).

min_k_bit_flips([], _, _, Count, _) -> Count;
min_k_bit_flips([H | T], Flips, K, Count, FlipCount) ->
    Index = length(Flips) - length(T) - 1,
    FlipIndex = if
        (FlipCount rem 2) == 0 -> 0;
        true -> 1
    end,
    Current = (H + FlipIndex) rem 2,
    NewFlipCount = if Current == 0 andalso Index + K =< length(Flips) -> 
        Flips1 = lists:sublist(Flips, 1, Index) ++ [1] ++ lists:sublist(Flips, Index + 1, K - 1) ++ [0] ++ lists:sublist(Flips, Index + K + 1);
        [{Flips1, Count + 1}];
        true -> {Flips, Count}
    end,
    min_k_bit_flips(T, elem(NewFlipCount, 1), K, elem(NewFlipCount, 2), elem(NewFlipCount, 3)).