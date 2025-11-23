-module(bst_iterator).
-export([new/1, has_next/1, next/1]).

-record(node, {val, left, right}).
-record(iterator, {stack}).

new(nil) ->
    #iterator{stack = []};
new(Node) ->
    Stack = traverse_left(Node),
    #iterator{stack = Stack}.

traverse_left(nil) ->
    [];
traverse_left(Node) ->
    [Node | traverse_left(Node#node.left)].

has_next(#iterator{stack = []}) ->
    false;
has_next(_) ->
    true.

next(#iterator{stack = [Node | Rest]} = It) ->
    Val = Node#node.val,
    NewStack = case Node#node.right of
        nil -> Rest;
        Right -> traverse_left(Right) ++ Rest
    end,
    {Val, It#iterator{stack = NewStack}}.