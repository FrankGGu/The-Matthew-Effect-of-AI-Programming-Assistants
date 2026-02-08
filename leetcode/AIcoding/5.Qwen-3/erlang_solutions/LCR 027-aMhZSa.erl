-module(palindrome_linked_list).
-export([is_palindrome/1]).

-record(list_node, {val, next}).

is_palindrome(Head) ->
    List = to_list(Head),
    is_palindrome(List).

to_list(null) ->
    [];
to_list(#list_node{val = Val, next = Next}) ->
    [Val | to_list(Next)].

is_palindrome(List) ->
    List == lists:reverse(List).