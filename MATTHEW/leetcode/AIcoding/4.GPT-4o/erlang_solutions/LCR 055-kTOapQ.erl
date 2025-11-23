-module(bst_iterator).
-export([new/1, next/1, has_next/1]).

-record(node, {val, left = none, right = none}).
-record(iterator, {stack}).

new(Root) ->
    Stack = [],
    Iter = #iterator{stack = push_left(Stack, Root)},
    Iter.

next(Iter) ->
    case Iter#iterator.stack of
        [] -> 
            undefined;
        [Top | Rest] ->
            NewIter = Iter#iterator{stack = Rest},
            {Top#node.val, NewIter}
    end.

has_next(Iter) ->
    Iter#iterator.stack =/= [].

push_left(Stack, none) ->
    Stack;
push_left(Stack, Node) ->
    push_left([Node | Stack], Node#node.left).