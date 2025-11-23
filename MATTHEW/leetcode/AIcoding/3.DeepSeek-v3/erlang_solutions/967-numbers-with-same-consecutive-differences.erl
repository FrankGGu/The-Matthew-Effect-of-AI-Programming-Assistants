-module(solution).
-export([nums_same_consec_diff/2]).

nums_same_consec_diff(N, K) ->
    Result = case N of
        1 -> lists:seq(0, 9);
        _ -> generate_numbers(N, K)
    end,
    lists:sort(Result).

generate_numbers(N, K) ->
    Queue = lists:seq(1, 9),
    generate_numbers(N - 1, K, Queue).

generate_numbers(0, _K, Queue) -> Queue;
generate_numbers(Remaining, K, Queue) ->
    NewQueue = lists:flatmap(fun(Number) ->
        LastDigit = Number rem 10,
        NextDigits = case K of
            0 -> [LastDigit];
            _ -> 
                case {LastDigit - K, LastDigit + K} of
                    {A, B} when A >= 0, B =< 9 -> [A, B];
                    {A, _} when A >= 0 -> [A];
                    {_, B} when B =< 9 -> [B];
                    _ -> []
                end
        end,
        [Number * 10 + D || D <- NextDigits]
    end, Queue),
    generate_numbers(Remaining - 1, K, NewQueue).