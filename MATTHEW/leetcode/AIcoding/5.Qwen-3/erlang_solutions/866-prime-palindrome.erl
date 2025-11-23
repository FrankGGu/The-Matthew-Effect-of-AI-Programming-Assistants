-module(prime_palindrome).
-export([prime_palindrome/1]).

prime_palindrome(N) ->
    find_prime_palindrome(N, 2).

find_prime_palindrome(N, Candidate) when Candidate < N ->
    find_prime_palindrome(N, Candidate + 1);
find_prime_palindrome(_, Candidate) ->
    case is_palindrome(Candidate) of
        true ->
            case is_prime(Candidate) of
                true -> Candidate;
                false -> find_prime_palindrome(N, Candidate + 1)
            end;
        false ->
            find_prime_palindrome(N, Candidate + 1)
    end.

is_palindrome(N) ->
    is_palindrome(N, []).

is_palindrome(0, Acc) ->
    lists:reverse(Acc) == Acc;
is_palindrome(N, Acc) ->
    is_palindrome(N div 10, [N rem 10 | Acc]).

is_prime(N) when N < 2 ->
    false;
is_prime(N) ->
    is_prime(N, 2).

is_prime(N, Div) when Div * Div > N ->
    true;
is_prime(N, Div) ->
    case N rem Div of
        0 -> false;
        _ -> is_prime(N, Div + 1)
    end.