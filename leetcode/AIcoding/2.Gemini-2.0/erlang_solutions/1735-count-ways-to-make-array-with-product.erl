-module(count_ways).
-export([number_of_ways/2]).

number_of_ways(Queries, Num) ->
    number_of_ways(Queries, Num, []).

number_of_ways([], _, Acc) ->
    lists:reverse(Acc);
number_of_ways([Query|Rest], Num, Acc) ->
    [N, K] = Query,
    Result = count_ways_helper(N, K, Num),
    number_of_ways(Rest, Num, [Result|Acc]).

count_ways_helper(N, K, Num) ->
    Factors = prime_factorization(Num),
    count_ways_helper(N, K, Factors, 1).

count_ways_helper(N, K, [], Acc) ->
    Acc;
count_ways_helper(N, K, [Factor|Rest], Acc) ->
    Count = lists:sum([1 || X <- prime_factorization(K), X == Factor]),
    Ways = combinations_with_replacement(N - 1, Count),
    count_ways_helper(N, K, Rest, (Acc * Ways) rem 1000000007).

prime_factorization(1) ->
    [];
prime_factorization(N) ->
    prime_factorization(N, 2, []).

prime_factorization(N, Factor, Acc) when Factor * Factor > N ->
    [N|Acc];
prime_factorization(N, Factor, Acc) when N rem Factor == 0 ->
    prime_factorization(N div Factor, Factor, [Factor|Acc]);
prime_factorization(N, Factor, Acc) ->
    prime_factorization(N, Factor + 1, Acc).

combinations_with_replacement(N, K) ->
    binomial_coefficient(N + K, K).

binomial_coefficient(N, K) ->
    case K > N - K of
        true ->
            binomial_coefficient(N, N - K);
        false ->
            binomial_coefficient_helper(N, K, 1)
    end.

binomial_coefficient_helper(N, 0, Acc) ->
    Acc rem 1000000007;
binomial_coefficient_helper(N, K, Acc) ->
    binomial_coefficient_helper(N - 1, K - 1, (Acc * N) div K rem 1000000007).