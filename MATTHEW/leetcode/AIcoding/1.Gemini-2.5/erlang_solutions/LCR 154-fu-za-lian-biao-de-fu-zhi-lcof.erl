-module(solution).
-export([copyRandomList/1]).

-record(node, {val, next = nil, random = nil}).

copyRandomList(nil) ->
    nil;
copyRandomList(Head) ->
    %% Step 1: Create a copy of each original node and insert it between
    %% the original node and its next node.
    %% Original list: A -> B -> C
    %% Modified list: A -> A' -> B -> B' -> C -> C'
    interleave_copies(Head),

    %% Step 2: Iterate through the interleaved list and set the 'random'
    %% pointers for the copied nodes.
    %% If OriginalNode.random points to TargetNode, then CopiedNode.random
    %% should point to TargetNode.copy (which is TargetNode.next in our interleaved list).
    set_random_pointers(Head),

    %% Step 3: Separate the original list from the copied list.
    %% This restores the original list's 'next' pointers and builds the new list.
    separate_lists(Head).

interleave_copies(nil) ->
    ok;
interleave_copies(#'node'{val=Val, next=OriginalNext, random=_Random} = OriginalNode) ->
    NewNode = #'node'{val=Val, next=OriginalNext, random=nil},
    OriginalNode#'node'{next=NewNode}, %% Assumed "mutation" of OriginalNode's next field
    interleave_copies(OriginalNext).

set_random_pointers(nil) ->
    ok;
set_random_pointers(#'node'{next=#'node'{val=_CopyVal, next=_CopyNext, random=_CopyRandom} = CopyNode, random=OriginalRandom} = OriginalNode) ->
    if
        OriginalRandom /= nil ->
            TargetCopyNode = OriginalRandom#'node'.next, %% TargetNode.copy is TargetNode.next
            CopyNode#'node'{random=TargetCopyNode}; %% Assumed "mutation" of CopyNode's random field
        true ->
            ok %% No random pointer to set if OriginalRandom is nil
    end,
    %% Move to the next original node (skipping its copy)
    set_random_pointers(OriginalNode#'node'.next#'node'.next).

separate_lists(nil) ->
    nil;
separate_lists(OriginalHead) ->
    NewHead = OriginalHead#'node'.next,
    separate_lists_recursive(OriginalHead, NewHead),
    NewHead.

separate_lists_recursive(nil, _NewCurrent) ->
    ok;
separate_lists_recursive(OriginalCurrent, NewCurrent) ->
    OriginalNext = NewCurrent#'node'.next, %% This is the next original node in the interleaved list
    NewNext = if OriginalNext /= nil -> OriginalNext#'node'.next; true -> nil end, %% This is the next copied node

    OriginalCurrent#'node'{next=OriginalNext}, %% Restore original list's next pointer
    NewCurrent#'node'{next=NewNext}, %% Set new list's next pointer

    separate_lists_recursive(OriginalNext, NewNext).