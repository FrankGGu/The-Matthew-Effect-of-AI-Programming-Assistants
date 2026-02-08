-record(list_node, {val = 0 :: integer(), next = nil :: 'list_node()' | nil}).

-spec splitListToParts(Head :: 'list_node()' | nil, K :: integer()) -> list('list_node()' | nil).
splitListToParts(Head, K) ->
    Len = get_length(Head),
    BaseSize = Len div K,
    Remainder = Len rem K,
    split_parts_recursive(Head, K, BaseSize, Remainder, []).

get_length(nil) -> 0;
get_length(Node) -> 1 + get_length(Node#list_node.next).

split_parts_recursive(CurrentNode, PartsRemaining, BaseSize, RemainderCount, Acc) when PartsRemaining > 0 ->
    PartSize = BaseSize + (if RemainderCount > 0 -> 1; true -> 0 end),
    ActualRemainderCount = if RemainderCount > 0 -> RemainderCount - 1; true -> 0 end,

    {HeadOfPart, NextStartNode} = extract_part_functional(CurrentNode, PartSize),
    split_parts_recursive(NextStartNode, PartsRemaining - 1, BaseSize, ActualRemainderCount, [HeadOfPart | Acc]);
split_parts_recursive(_CurrentNode, 0, _BaseSize, _RemainderCount, Acc) ->
    lists:reverse(Acc).

extract_part_functional(StartNode, Size) ->
    if
        Size == 0 ->
            {nil, StartNode};
        StartNode == nil ->
            {nil, nil};
        true ->
            build_part(StartNode, Size, [])
    end.

build_part(CurrentOriginalNode, NodesToTake, Acc) ->
    if
        NodesToTake == 0 ->
            NewHead = lists:foldl(fun(V, AccNode) -> #list_node{val = V, next = AccNode} end, nil, lists:reverse(Acc)),
            {NewHead, CurrentOriginalNode};
        CurrentOriginalNode == nil ->
            NewHead = lists:foldl(fun(V, AccNode) -> #list_node{val = V, next = AccNode} end, nil, lists:reverse(Acc)),
            {NewHead, nil};
        true ->
            build_part(CurrentOriginalNode#list_node.next, NodesToTake - 1, [CurrentOriginalNode#list_node.val | Acc])
    end.