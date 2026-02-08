-module(solution).
-export([max_palindromes/2]).

max_palindromes(N, k) ->
    Count = N div k,
    if
        N rem k =:= 0 -> Count;
        true -> Count + 1
    end.