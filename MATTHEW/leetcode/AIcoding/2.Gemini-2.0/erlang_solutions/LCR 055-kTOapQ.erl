-module(bst_iterator).
-export([new/1, hasNext/1, next/1]).

-record(state, {stack}).

new(Root) ->
    #state{stack = push_all_left(Root, [])}.

hasNext(#state{stack = []}) ->
    false;
hasNext(#state{stack = _}) ->
    true.

next(#state{stack = [Node | Rest]}) ->
    case Node of
        null ->
            {null, #state{stack = Rest}};
        #{} ->
            Val = maps:get(val, Node),
            Right = maps:get(right, Node, null),
            {#state{stack = push_all_left(Right, Rest)}, Val};
        _ ->
            {null, #state{stack = Rest}}
    end.

push_all_left(null, Stack) ->
    Stack;
push_all_left(Node, Stack) ->
    push_all_left(maps:get(left, Node, null), [Node | Stack]).