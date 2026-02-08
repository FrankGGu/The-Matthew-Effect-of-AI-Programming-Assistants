-module(four_divisors).
-export([sum_four_divisors/1]).

sum_four_divisors(Nums) ->
    lists:sum([sum_divisors(N) || N <- Nums]).

sum_divisors(N) ->
    Divisors = divisors(N),
    case length(Divisors) of
        4 -> lists:sum(Divisors);
        _ -> 0
    end.

divisors(N) ->
    divisors_helper(N, 1, []).

divisors_helper(N, I, Acc) when I * I > N ->
    lists:reverse(Acc);
divisors_helper(N, I, Acc) ->
    if N rem I == 0 ->
        if I * I == N ->
            divisors_helper(N, I + 1, [I | Acc]);
        true ->
            divisors_helper(N, I + 1, [N div I, I | Acc]);
        false ->
            divisors_helper(N, I + 1, Acc)
    end.