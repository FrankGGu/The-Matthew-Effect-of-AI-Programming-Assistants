-module(defuse_the_bomb).
-export([decrypt/2]).

decrypt(Code, K) ->
    N = length(Code),
    lists:map(fun(I) ->
                      Sum = case K > 0 of
                                true ->
                                    sum_range(Code, (I + 1) rem N, K, N);
                                false ->
                                    sum_range(Code, (I + N + K) rem N, -K, N)
                            end,
                      Sum
              end, lists:seq(0, N - 1)).

sum_range(_Code, Start, 0, _N) -> 0;
sum_range(Code, Start, Count, N) ->
    case Count > 0 of
        true ->
            Val = lists:nth(Start + 1, Code),
            Val + sum_range(Code, (Start + 1) rem N, Count - 1, N);
        false ->
            Val = lists:nth(Start + 1, Code),
            Val + sum_range(Code, (Start - 1 + N) rem N, Count + 1, N)
    end.