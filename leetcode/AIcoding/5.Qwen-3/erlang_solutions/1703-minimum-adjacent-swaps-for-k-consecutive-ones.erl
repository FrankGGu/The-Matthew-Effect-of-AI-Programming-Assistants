-module(min_adjacent_swaps_for_k_consecutive_ones).
-export([minAdjSwaps/2]).

minAdjSwaps(Nums, K) ->
    N = length(Nums),
    Ones = [I || {I, 1} <- lists:enumerate(Nums)],
    if
        length(Ones) < K -> 0;
        true ->
            len = length(Ones),
            lists:foldl(fun(I, Acc) ->
                                Start = I,
                                End = I + K - 1,
                                if
                                    End > len -> Acc;
                                    true ->
                                        Sub = lists:sublist(Ones, Start, K),
                                        Mid = lists:nth(K div 2 + 1, Sub),
                                        Total = lists:foldl(fun(J, T) -> T + abs(Mid - J) end, 0, Sub),
                                        min(Acc, Total)
                                end
                            end, infinity, lists:seq(1, len - K + 1))
    end.

min(A, B) when A < B -> A;
min(_, B) -> B.