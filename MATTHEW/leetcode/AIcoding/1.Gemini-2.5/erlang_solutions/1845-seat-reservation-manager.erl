-module(seat_manager).
-export([new/1, reserve/1, unreserve/2]).

-record(state, {next_available_seat :: integer(),
                unreserved_seats :: gb_trees:tree()}).

new(_N) ->
    % N is the total number of seats, but the logic only requires tracking the smallest available.
    % We start with seat 1 as the next available and an empty set of unreserved seats.
    #state{next_available_seat = 1,
           unreserved_seats = gb_trees:empty()}.

reserve(#state{next_available_seat = NextAvailable, unreserved_seats = Unreserved} = State) ->
    case gb_trees:is_empty(Unreserved) of
        true ->
            % If no previously unreserved seats are available, take the next one in sequence.
            {NextAvailable, State#state{next_available_seat = NextAvailable + 1}};
        false ->
            % Otherwise, take the smallest seat from the unreserved set.
            {MinSeat, _Value, NewUnreserved} = gb_trees:take_smallest(Unreserved),
            {MinSeat, State#state{unreserved_seats = NewUnreserved}}
    end.

unreserve(Seat, #state{next_available_seat = NextAvailable, unreserved_seats = Unreserved} = State) ->
    if
        Seat < NextAvailable ->
            % If the unreserved seat is smaller than the current 'NextAvailable',
            % it means it was previously taken from the unreserved_seats tree,
            % or NextAvailable moved past it. Just add it back to the tree.
            NewUnreserved = gb_trees:enter(Seat, true, Unreserved),
            State#state{unreserved_seats = NewUnreserved};
        Seat == NextAvailable ->
            % If the unreserved seat is equal to 'NextAvailable', it means this seat
            % was previously 'NextAvailable', got reserved, and then 'NextAvailable'
            % incremented to Seat + 1. Now that Seat is unreserved, 'NextAvailable'
            % should revert to Seat. We also need to check if contiguous seats
            % below Seat are also in the unreserved_seats tree and can be absorbed
            % into the 'NextAvailable' counter.
            unreserve_and_cleanup(Seat, Unreserved, State);
        true -> % Seat > NextAvailable
            % This case should not be reachable based on the problem constraints
            % ("guaranteed to be previously reserved"). If a seat was reserved,
            % it must have been either 'NextAvailable' (before increment) or from 'Unreserved'.
            % In both scenarios, 'Seat <= NextAvailable' would hold at the time of unreserve.
            % For robustness, we return the original state.
            State
    end.

unreserve_and_cleanup(CurrentSeatCandidate, UnreservedTree, OriginalState) ->
    % This helper function recursively checks for contiguous available seats below CurrentSeatCandidate
    % that are currently in UnreservedTree, and removes them, effectively decrementing
    % the 'next_available_seat' counter.
    case CurrentSeatCandidate of
        1 ->
            % Cannot go below 1. This is the final next_available_seat.
            OriginalState#state{next_available_seat = 1, unreserved_seats = UnreservedTree};
        _ ->
            % Check if the seat immediately before CurrentSeatCandidate is in the unreserved tree.
            % If it is, it means we can absorb it into the 'next_available_seat' counter.
            case gb_trees:is_defined(CurrentSeatCandidate - 1, UnreservedTree) of
                true ->
                    NewUnreservedTree = gb_trees:delete(CurrentSeatCandidate - 1, UnreservedTree),
                    unreserve_and_cleanup(CurrentSeatCandidate - 1, NewUnreservedTree, OriginalState);
                false ->
                    % If CurrentSeatCandidate - 1 is not in the tree, then CurrentSeatCandidate
                    % is the smallest available seat.
                    OriginalState#state{next_available_seat = CurrentSeatCandidate, unreserved_seats = UnreservedTree}
            end
    end.