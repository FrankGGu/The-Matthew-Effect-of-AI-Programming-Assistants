-module(preimage_size).
-export([preimage_size/1]).

preimage_size(K) ->
    upper_bound(K) - lower_bound(K) + 1.

upper_bound(K) ->
    find_k(K).

lower_bound(K) ->
    find_k(K - 1) + 1.

find_k(K) ->
    find_k(K, 0, 5 * (K + 1)).

find_k(K, Low, High) ->
    if
        Low > High ->
            High;
        true ->
            Mid = Low + (High - Low) div 2,
            Zeros = trailing_zeros(Mid),
            if
                Zeros =:= K ->
                    find_k(K, Low, Mid - 1);
                Zeros < K ->
                    find_k(K, Mid + 1, High);
                true ->
                    find_k(K, Low, Mid - 1)
            end
    end.

trailing_zeros(N) ->
    trailing_zeros(N, 0).

trailing_zeros(N, Acc) ->
    if
        N == 0 ->
            Acc;
        true ->
            trailing_zeros(N div 5, Acc + N div 5)
    end.