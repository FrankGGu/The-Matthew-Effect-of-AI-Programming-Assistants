-module(solution).
-export([max_value/3]).

max_value(N, K, V) ->
    max_value(N, K, V, 1, V).

max_value(N, K, V, Low, High) ->
    Mid = (Low + High) div 2,
    if
        is_valid(N, K, V, Mid) ->
            case Mid of
                High -> High;
                _ -> max_value(N, K, V, Mid + 1, High)
            end;
        true ->
            max_value(N, K, V, Low, Mid - 1)
    end.

is_valid(N, K, V, X) ->
    Left = K,
    Right = N - K - 1,
    Total = 0,
    Total = Total + get_sum(X, Left),
    Total = Total + get_sum(X, Right),
    Total < V.

get_sum(X, Len) when Len == 0 -> 0;
get_sum(X, Len) ->
    Min = min(X, Len + 1),
    Sum = (X + X - Min + 1) * Min div 2,
    if
        Len >= X -> Sum;
        true -> Sum - (X - Len - 1) * (X - Len) div 2
    end.