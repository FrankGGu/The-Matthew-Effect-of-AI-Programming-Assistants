-module(minimum_adjacent_swaps_for_k_consecutive_ones).
-export([min_moves/2]).

min_moves(Nums, K) ->
    Ones = lists:foldl(fun(N, Acc) -> if N == 1 -> [Acc || Acc <- [length(Acc)]] ++ [Acc] else Acc end, [], Nums),
    Len = length(Ones),
    PrefixSum = calculate_prefix_sum(Ones),
    Median = K div 2,
    Odd = K rem 2,
    lists:foldl(fun(I, Acc) ->
        Start = I - Median,
        End = I + (K - Median - 1 - Odd),
        if Start < 0 orelse End >= Len then
            Acc
        else
            MidIndex = Ones[I+1],
            Left = (PrefixSum[End+2] - PrefixSum[I+1]) - (End - I) * MidIndex,
            Right = (I - Start) * MidIndex - (PrefixSum[I+1] - PrefixSum[Start+1]),
            Moves = Left + Right - calculate_arithmetic_progression(K div 2) - calculate_arithmetic_progression((K - 1) div 2),
            min(Acc, Moves)
        end
    end, 9999999999999, lists:seq(Median, Len - (K - Median))).

calculate_prefix_sum(List) ->
    lists:foldl(fun(N, {Sum, Acc}) -> {Sum + N, Acc ++ [Sum + N]} end, {0, [0]}, List).

calculate_arithmetic_progression(N) ->
    N * (N + 1) div 2.