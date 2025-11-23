-record('ListNode', {val :: integer(), next :: 'ListNode'() | nil}).

-export([mergeNodes/1]).

mergeNodes(nil) -> nil;
mergeNodes(#'ListNode'{val=0, next=NextNode}) ->
    merge_and_build(NextNode, 0).

merge_and_build(nil, _) ->
    nil;
merge_and_build(#'ListNode'{val=0, next=NextNode}, Accumulator) ->
    NewNode = #'ListNode'{val=Accumulator, next=merge_and_build(NextNode, 0)},
    NewNode;
merge_and_build(#'ListNode'{val=Val, next=NextNode}, Accumulator) ->
    merge_and_build(NextNode, Accumulator + Val).