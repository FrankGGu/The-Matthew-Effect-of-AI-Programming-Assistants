-module(min_operations).
-export([minimumOperations/1]).

minimumOperations(Number) ->
    N = length(Number),
    Digits = [lists:nth(I, Number) - $0 || I <- lists:seq(1, N)],
    Count = 0,
    minimumOperations(Digits, N, Count).

minimumOperations([], _, Count) ->
    Count;
minimumOperations([D | Rest], N, Count) ->
    if
        D == 0 ->
            minimumOperations(Rest, N, Count);
        true ->
            if
                N == 1 ->
                    Count + 1;
                true ->
                    minimumOperations(Rest, N - 1, Count + 1)
            end
    end.