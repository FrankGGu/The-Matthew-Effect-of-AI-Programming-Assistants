-module(bst_to_dll).
-export([convert/1]).

-record(bst, {val, left, right}).

convert(undefined) -> undefined;
convert(Node) ->
    {Head, _} = convert_helper(Node),
    Head.

convert_helper(undefined) -> {undefined, undefined};
convert_helper(Node) ->
    {LeftHead, LeftTail} = convert_helper(Node#bst.left),
    {RightHead, RightTail} = convert_helper(Node#bst.right),
    Node#bst.left = LeftTail,
    Node#bst.right = RightHead,
    if
        LeftTail /= undefined ->
            LeftTail#bst.right = Node;
        true ->
            ok
    end,
    if
        RightHead /= undefined ->
            RightHead#bst.left = Node;
        true ->
            ok
    end,
    Head = case LeftHead of
               undefined -> Node;
               _ -> LeftHead
           end,
    Tail = case RightTail of
               undefined -> Node;
               _ -> RightTail
           end,
    {Head, Tail}.