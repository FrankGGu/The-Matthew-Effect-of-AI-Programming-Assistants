-module(solution).
-export([check_palindrome/1, is_pali_partition/1]).

check_palindrome(S) ->
    lists:all(fun(I) -> lists:sublist(S, I, length(S) - I + 1) =:= lists:reverse(lists:sublist(S, I, length(S) - I + 1)) end, lists:seq(1, length(S))).

is_pali_partition(S) ->
    case lists:seq(0, length(S) - 1) of
        [] -> false;
        Indices -> 
            lists:any(fun(I) -> check_palindrome(lists:sublist(S, 0, I)) andalso check_palindrome(lists:sublist(S, I, length(S) - I)) end, Indices)
    end.

is_pali_partition(S) -> 
    case lists:seq(1, length(S)) of
        [] -> false;
        Indices ->
            lists:any(fun(I) -> check_palindrome(lists:sublist(S, 0, I)) andalso check_palindrome(lists:sublist(S, I, length(S) - I)) end, Indices)
    end.