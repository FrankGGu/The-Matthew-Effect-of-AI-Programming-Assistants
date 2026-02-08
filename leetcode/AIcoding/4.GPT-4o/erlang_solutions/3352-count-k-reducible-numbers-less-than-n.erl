-module(solution).
-export([count_k_reducible_numbers/2]).

count_k_reducible_numbers(N, K) ->
    Count = fun(M) -> 
        case k_reducible(M, K) of
            true -> 1;
            false -> 0
        end
    end,
    lists:sum(lists:map(Count, lists:seq(1, N - 1))).

k_reducible(N, K) ->
    Digits = integer_to_list(N),
    lists:all(fun(Digit) -> (list_to_integer([Digit]) rem K) =:= 0 end, Digits).