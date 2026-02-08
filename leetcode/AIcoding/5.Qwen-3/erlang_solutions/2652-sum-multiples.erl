-module(solution).
-export([sum_multiples/1]).

sum_multiples(N) ->
    sum_multiples(N, 0, 0).

sum_multiples(N, I, Sum) when I >= N ->
    Sum;
sum_multiples(N, I, Sum) ->
    case (I rem 3 == 0) or (I rem 5 == 0) of
        true ->
            sum_multiples(N, I + 1, Sum + I);
        false ->
            sum_multiples(N, I + 1, Sum)
    end.