-module(solution).
-export([isPalindrome/1]).

isPalindrome(S) ->
    Filtered = filter_and_lower(S),
    Filtered == lists:reverse(Filtered).

filter_and_lower(S) ->
    lists:foldl(fun(Char, Acc) ->
                    if erlang:is_alphanum(Char) ->
                           [erlang:to_lower(Char) | Acc];
                       true ->
                           Acc
                    end
                end, [], S).