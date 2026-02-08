-module(solution).
-export([super_palindromes_count/2]).

super_palindromes_count(A, B) ->
    A1 = list_to_integer(A),
    B1 = list_to_integer(B),
    Count = count_super_palindromes(A1, B1),
    Count.

count_super_palindromes(A, B) ->
    Max = trunc(math:sqrt(B)),
    Min = trunc(math:sqrt(A)),
    lists:foldl(fun(N, Acc) ->
        Palindrome = N * N,
        if
            Palindrome >= A andalso Palindrome =< B andalso is_palindrome(Palindrome) ->
                Acc + 1;
            true ->
                Acc
        end
    end, 0, generate_palindromes(Min, Max)).

generate_palindromes(Min, Max) ->
    lists:flatmap(fun(X) -> [X, reverse(X)] end, lists:seq(Min, Max)) ++
    lists:flatmap(fun(X) -> [X, reverse(X), X ++ [last(X)]] end, lists:seq(Min, Max)).

is_palindrome(N) ->
    S = integer_to_list(N),
    S == lists:reverse(S).