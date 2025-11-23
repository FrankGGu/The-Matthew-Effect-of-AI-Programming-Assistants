-module(solution).
-export([sortList/1]).

-record(list_node, {val, next}).

sortList(null) -> null;
sortList(Node) ->
    case Node#list_node.next of
        null -> Node;
        _ ->
            {FirstHalfHead, SecondHalfHead} = split_list(Node),
            SortedFirstHalf = sortList(FirstHalfHead),
            SortedSecondHalf = sortList(SecondHalfHead),
            merge_two_lists(SortedFirstHalf, SortedSecondHalf)
    end.

split_list(Head) ->
    split_list_impl(Head, Head, Head, null).

split_list_impl(OriginalHead, Slow, null, Prev) ->
    {terminate_list(OriginalHead, Prev), Slow};
split_list_impl(OriginalHead, Slow, #list_node{next = null}, Prev) ->
    {terminate_list(OriginalHead, Prev), Slow};
split_list_impl(OriginalHead, Slow, #list_node{next = FastNext}, Prev) ->
    split_list_impl(OriginalHead, Slow#list_node.next, FastNext#list_node.next, Slow).

terminate_list(Current, TargetNode) when Current == TargetNode ->
    TargetNode#list_node{next = null};
terminate_list(Current, TargetNode) ->
    Current#list_node{next = terminate_list(Current#list_node.next, TargetNode)}.

merge_two_lists(null, L2) -> L2;
merge_two_lists(L1, null) -> L1;
merge_two_lists(#list_node{val = V1, next = N1} = L1, #list_node{val = V2, next = N2} = L2) ->
    if V1 =< V2 ->
        L1#list_node{next = merge_two_lists(N1, L2)};
    true ->
        L2#list_node{next = merge_two_lists(L1, N2)}
    end.