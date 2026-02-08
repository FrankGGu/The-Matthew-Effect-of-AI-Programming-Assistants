-module(palindromic).
-export([is_palindrome/1]).

is_palindrome(N) ->
    is_palindrome(N, 2).

is_palindrome(N, Base) when Base > N ->
    true;
is_palindrome(N, Base) ->
    Str = integer_to_list(N, Base),
    is_palindrome(Str).

is_palindrome([]) ->
    true;
is_palindrome([H|T]) ->
    case H == lists:last(T) of
        true -> is_palindrome(lists:tl(T));
        false -> false
    end.