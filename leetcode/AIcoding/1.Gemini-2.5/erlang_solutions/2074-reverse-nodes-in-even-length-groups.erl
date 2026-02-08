-module(solution).
-export([reverse_even_length_groups/1]).

-record(list_node, {val, next}).

reverse_even_length_groups(Head) ->
    reverse_even_length_groups_recursive(Head, 1).

reverse_even_length_groups_recursive(null, _GroupNum) ->
    null;
reverse_even_length_groups_recursive(CurrentNode, GroupNum) ->
    {GroupNodesList, NextGroupHead, ActualGroupLength} = collect_group_nodes(CurrentNode, GroupNum, [], 0),

    NewNextGroupHead = reverse_even_length_groups_recursive(NextGroupHead, GroupNum + 1),

    if ActualGroupLength rem 2 == 0 ->
        link_nodes_and_return_head(GroupNodesList, NewNextGroupHead);
    true ->
        OriginalOrderGroupNodes = lists:reverse(GroupNodesList),
        link_nodes_and_return_head(OriginalOrderGroupNodes, NewNextGroupHead)
    end.

collect_group_nodes(#list_node{next = NextNode} = Current, N, AccNodes, Count) when Count < N ->
    collect_group_nodes(NextNode, N, [Current | AccNodes], Count + 1);
collect_group_nodes(Current, _N, AccNodes, Count) ->
    {AccNodes, Current, Count}.

link_nodes_and_return_head([], _FinalNext) ->
    null;
link_nodes_and_return_head([Node], FinalNext) ->
    Node#list_node{next = FinalNext};
link_nodes_and_return_head([Node | Rest], FinalNext) ->
    Node#list_node{next = link_nodes_and_return_head(Rest, FinalNext)}.