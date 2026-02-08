-module(bst_iterator).
-export([new/1, has_next/1, next/1]).

-record(bst_iterator, {stack = []}).

new(nil) ->
    #bst_iterator{stack = []};
new(Node) ->
    Stack = get_leftmost(Node),
    #bst_iterator{stack = Stack}.

get_leftmost(Node) ->
    case Node of
        nil -> [];
        _ ->
            [Node | get_leftmost(Node#node.left)]
    end.

has_next(#bst_iterator{stack = []}) ->
    false;
has_next(_) ->
    true.

next(#bst_iterator{stack = [Node | Rest]} = It) ->
    Value = Node#node.val,
    NewStack = case Node#node.right of
                   nil -> Rest;
                   Right -> get_leftmost(Right) ++ Rest
               end,
    It#bst_iterator{stack = NewStack},
    Value.

-record(node, {val, left, right}).