-module(maximize_score).
-export([maximum_score/2]).

maximum_score(Nums, K) ->
    Primes = sieve(lists:max(Nums)),
    Factors = [count_factors(N, Primes) || N <- Nums],
    SortedFactors = lists:sort(lists:reverse(Factors)),
    lists:sum(lists:sublist(SortedFactors, 1, K)).

sieve(N) ->
    sieve_helper(lists:seq(2, N), []).

sieve_helper([], Acc) ->
    lists:reverse(Acc);
sieve_helper([H | T], Acc) ->
    sieve_helper([X || X <- T, X rem H /= 0], [H | Acc]).

count_factors(N, Primes) ->
    count_factors_helper(N, Primes, 0).

count_factors_helper(1, _, Count) ->
    Count;
count_factors_helper(N, [], Count) ->
    Count;
count_factors_helper(N, [H | T], Count) ->
    case N rem H of
        0 ->
            count_factors_helper(N div H, [H | T], Count + 1);
        _ ->
            count_factors_helper(N, T, Count)
    end.