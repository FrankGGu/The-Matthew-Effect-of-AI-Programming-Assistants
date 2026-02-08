-module(solution).
-export([is_palindrome/1]).

is_palindrome(S) ->
    Filtered = filter_and_lower(S),
    Filtered == lists:reverse(Filtered).

filter_and_lower(S) ->
    lists:filtermap(fun(C) ->
        if
            C >= $a andalso C <= $z -> {true, C};
            C >= $A andalso C <= $Z -> {true, C + ($a - $A)};
            C >= $0 andalso C <= $9 -> {true, C};
            true -> false
        end
    end, S).