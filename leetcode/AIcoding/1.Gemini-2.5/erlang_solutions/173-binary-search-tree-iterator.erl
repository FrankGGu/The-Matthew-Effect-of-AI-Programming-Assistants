-module(bst_iterator).

-export([new/1, next/1, has_next/1]).

new(Root) ->
    push_left_spine(Root, []).

next([#{val := Val, right := RightChild} | RestStack]) ->
    NewStack = push_left_spine(RightChild, RestStack),
    {Val, NewStack}.

has_next([]) ->
    false;
has_next(_) ->
    true.

push_left_spine(nil, Stack) ->
    Stack;
push_left_spine(#{left := LeftChild} = Node, Stack) ->
    push_left_spine(LeftChild, [Node | Stack]).