-module(solution).
-export([prime_palindrome/0]).

prime_palindrome() ->
    lists:filter(fun(X) -> is_prime(X) andalso is_palindrome(X) end, lists:seq(1, 1000000)).

is_prime(N) when N < 2 -> false;
is_prime(N) ->
    lists:all(fun(X) -> N rem X /= 0 end, lists:seq(2, trunc(math:sqrt(N)))).

is_palindrome(N) ->
    S = integer_to_list(N),
    S == lists:reverse(S).