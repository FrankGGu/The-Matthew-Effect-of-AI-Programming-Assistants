-module(solution).
-export([detectCycle/1]).

detectCycle(Head) ->
    % The initial call to find_intersection starts with both slow and fast pointers at Head.
    % We pass Head as the first argument, which represents the original head of the list,
    % needed later to find the cycle's starting node.
    find_intersection(Head, Head, Head).

find_intersection(OriginalHead, Slow, Fast) ->
    case {Slow, Fast} of
        % If Slow or Fast pointers become nil, there is no cycle.
        {nil, _} -> nil;
        {_, nil} -> nil;
        % If FastPointer's next is nil, it means FastPointer is the last node,
        % so it cannot move two steps. No cycle.
        {_, #{next := nil}} -> nil;
        % If FastPointer's next's next is nil, it means FastPointer's next is the last node,
        % so FastPointer cannot move two steps. No cycle.
        {_, #{next := #{next := nil}}} -> nil;
        % If none of the above base cases match, both Slow and Fast (and Fast's next) are valid nodes.
        {_, _} ->
            % Move SlowPointer one step
            NewSlow = Slow#{next},
            % Move FastPointer two steps
            NewFast = (Fast#{next})#{next},

            if
                NewSlow == NewFast ->
                    % Cycle detected: Slow and Fast pointers have met.
                    % Now, find the starting node of the cycle.
                    find_cycle_start(OriginalHead, NewSlow);
                true ->
                    % No cycle detected yet, continue moving pointers.
                    find_intersection(OriginalHead, NewSlow, NewFast)
            end
    end.

find_cycle_start(Ptr1, Ptr2) ->
    if
        Ptr1 == Ptr2 ->
            % They meet at the cycle's starting node.
            Ptr1;
        true ->
            % Continue moving both pointers one step.
            find_cycle_start(Ptr1#{next}, Ptr2#{next})
    end.