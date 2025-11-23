-module(solution).
-export([is_palindrome/1]).

-record(node, {val, next}).

is_palindrome(List) ->
    Reversed = reverse_list(List, #node{next = none}),
    is_equal(List, Reversed).

reverse_list(nil, Reversed) -> Reversed;
reverse_list(#node{val=Val, next=Next} = Node, Acc) ->
    reverse_list(Next, #node{val=Val, next=Acc}).

is_equal(nil, nil) -> true;
is_equal(#node{val=Val1, next=Next1}, #node{val=Val2, next=Next2}) ->
    Val1 =:= Val2 andalso is_equal(Next1, Next2).