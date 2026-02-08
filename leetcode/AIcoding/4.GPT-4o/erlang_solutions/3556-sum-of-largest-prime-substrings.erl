-module(solution).
-export([largest_prime_sum/1]).

largest_prime_sum(S) ->
    Substrings = all_substrings(S),
    PrimeNumbers = lists:filter(fun is_prime/1, Substrings),
    lists:sum(PrimeNumbers).

all_substrings(S) ->
    Length = string:length(S),
    lists:flatmap(fun(I) -> lists:map(fun(J) -> string:substr(S, I, J) end, lists:seq(1, Length - I + 1)) end, lists:seq(1, Length)).

is_prime(N) when N < 2 -> false;
is_prime(2) -> true;
is_prime(N) -> lists:all(fun(X) -> N rem X /= 0 end, lists:seq(2, trunc(math:sqrt(N)))).