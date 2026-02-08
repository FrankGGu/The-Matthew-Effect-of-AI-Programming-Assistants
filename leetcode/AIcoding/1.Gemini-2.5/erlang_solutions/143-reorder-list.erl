-module(solution).
-export([reorder_list/1]).

-record(list_node, {val = 0, next = nil}).

reorder_list(nil) -> nil;
reorder_list(#list_node{next = nil} = Head) -> Head;
reorder_list(Head) ->
    % 1. Find the node before the middle and the middle node itself
    {PrevSlow, Mid} = find_middle_and_split(Head),

    % 2. Rebuild the first half, terminating it at PrevSlow
    % This creates new list_node records for the first half, effectively splitting it.
    FirstHalfHead = rebuild_first_half_tco(Head, PrevSlow),

    % 3. Reverse the second half
    ReversedSecondHalf = reverse_list_tco(Mid, nil),

    % 4. Merge the two halves alternately
    merge_halves_tco(FirstHalfHead, ReversedSecondHalf).

find_middle_and_split(Head) -> find_middle_and_split(Head, Head, nil).
find_middle_and_split(Slow, nil, PrevSlow) -> {PrevSlow, Slow};
find_middle_and_split(Slow, #list_node{next = nil}, PrevSlow) -> {PrevSlow, Slow};
find_middle_and_split(Slow, #list_node{next = #list_node{next = FastNextNext}}, PrevSlow) ->
    find_middle_and_split(Slow#list_node.next, FastNextNext, Slow).

rebuild_first_half_tco(Head, StopNode) ->
    rebuild_first_half_tco(Head, StopNode, nil).

rebuild_first_half_tco(nil, _, Acc) ->
    reverse_list_tco(Acc, nil); % Reverse the accumulated nodes
rebuild_first_half_tco(Current, StopNode, Acc) when Current == StopNode ->
    % When Current reaches StopNode, add it to accumulator and reverse.
    % The 'next' of StopNode in the new list will be nil.
    reverse_list_tco(#list_node{val = Current#list_node.val, next = Acc}, nil);
rebuild_first_half_tco(#list_node{val = Val, next = Next}, StopNode, Acc) ->
    % Accumulate nodes in reverse order
    rebuild_first_half_tco(Next, StopNode, #list_node{val = Val, next = Acc}).

reverse_list_tco(nil, Acc) -> Acc;
reverse_list_tco(#list_node{val = Val, next = Next}, Acc) ->
    reverse_list_tco(Next, #list_node{val = Val, next = Acc}).

merge_halves_tco(L1, L2) -> merge_halves_tco(L1, L2, nil).
merge_halves_tco(nil, L2, Acc) -> reverse_list_tco(Acc, L2); % Append remaining L2 to reversed Acc
merge_halves_tco(L1, nil, Acc) -> reverse_list_tco(Acc, L1); % Append remaining L1 to reversed Acc
merge_halves_tco(#list_node{val = Val1, next = Next1}, #list_node{val = Val2, next = Next2}, Acc) ->
    % Interleave and accumulate in reverse order
    merge_halves_tco(Next1, Next2, #list_node{val = Val2, next = #list_node{val = Val1, next = Acc}}).