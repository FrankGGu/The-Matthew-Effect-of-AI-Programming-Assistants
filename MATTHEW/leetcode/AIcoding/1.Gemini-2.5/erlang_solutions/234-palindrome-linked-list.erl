-record(list_node, {val, next}).

-export([isPalindrome/1]).

isPalindrome(Head) ->
    ErlangList = list_to_erlang_list(Head),
    ErlangList == lists:reverse(ErlangList).

list_to_erlang_list(null) -> [];
list_to_erlang_list(#list_node{val = Val, next = Next}) ->
    [Val | list_to_erlang_list(Next)].