-module(bst_iterator).
-export([new/1, next/1, has_next/1]).

new(Root) ->
    push_left_nodes(Root, []).

next([CurrentNode | RestStack]) ->
    {Val, _, Right} = CurrentNode,
    NewStack = push_left_nodes(Right, RestStack),
    {Val, NewStack}.

has_next([]) -> false;
has_next(_) -> true.

push_left_nodes(nil, Stack) ->
    Stack;
push_left_nodes({_, Left, _} = Node, Stack) ->
    push_left_nodes(Left, [Node | Stack]).