-module(solution).
-export([isPalindrome/1]).

isPalindrome(Head) ->
    List = to_erlang_list(Head),
    is_palindrome_erlang_list(List).

to_erlang_list(null) -> [];
to_erlang_list(#{val := V, next := Next}) ->
    [V | to_erlang_list(Next)].

is_palindrome_erlang_list(List) ->
    List == lists:reverse(List).