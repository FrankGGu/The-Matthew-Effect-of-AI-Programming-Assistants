-module(solution).
-export([maxEvents/1]).

maxEvents(Events) ->
    % Sort events by start day. If start days are equal, the order doesn't strictly
    % matter for adding to the priority queue, but a consistent order is good.
    SortedEvents = lists:sort(fun([S1, _], [S2, _]) -> S1 < S2 end, Events),

    % Find the maximum end day to know when to stop iterating through days.
    % If Events is empty, MaxEndDay will be 0.
    MaxEndDay = lists:foldl(fun([_, E], Acc) -> max(E, Acc) end, 0, Events),

    % Find the minimum start day to know when to begin processing.
    % If Events is empty, MinStartDay will be 100001 (a value larger than any possible end day).
    MinStartDay = lists:foldl(fun([S, _], Acc) -> min(S, Acc) end, 100001, Events),

    % Call the recursive helper function to process days.
    % State: CurrentDay, MaxEndDay, EventsToStart (events not yet started),
    %        PriorityQueue (active events, ordered by end_day), AttendedCount, UniqueRefCounter
    solve(MinStartDay, MaxEndDay, SortedEvents, gb_trees:empty(), 0, 0).

solve(CurrentDay, MaxEndDay, _EventsToStart, _PriorityQueue, AttendedCount, _RefCounter) when CurrentDay > MaxEndDay ->
    AttendedCount;
solve(_CurrentDay, _MaxEndDay, [], PQ, AttendedCount, _RefCounter) when gb_trees:is_empty(PQ) ->
    AttendedCount;
solve(CurrentDay, MaxEndDay, EventsToStart, PriorityQueue, AttendedCount, RefCounter) ->
    % 1. Add events that start on CurrentDay to the PriorityQueue.
    %    EventsToStart is sorted by start day. `lists:splitwith` extracts all events
    %    whose start day is exactly `CurrentDay`.
    {EventsStartingNow, RemainingEventsToStart} = lists:splitwith(fun([S, _]) -> S == CurrentDay end, EventsToStart),

    % Add these events to the PriorityQueue. The key is `{EndDay, UniqueRef}` to handle
    % cases where multiple events have the same end day. `UniqueRef` is a simple counter.
    {NewPriorityQueue, NewRefCounter} = lists:foldl(
        fun([_, E], {PQ, RefC}) ->
            {gb_trees:insert({E, RefC}, true, PQ), RefC + 1}
        end, {PriorityQueue, RefCounter}, EventsStartingNow
    ),

    % 2. Remove expired events from the PriorityQueue.
    %    Events whose end day is less than CurrentDay cannot be attended.
    CleanPriorityQueue = remove_expired_events(CurrentDay, NewPriorityQueue),

    % 3. Try to attend an event on CurrentDay.
    case gb_trees:is_empty(CleanPriorityQueue) of
        true ->
            % No event available to attend today. Move to the next day.
            solve(CurrentDay + 1, MaxEndDay, RemainingEventsToStart, CleanPriorityQueue, AttendedCount, NewRefCounter);
        false ->
            % Attend the event with the earliest end day (top of the min-priority queue).
            % We don't need the actual event data, just to remove it from the queue.
            AttendedPriorityQueue = gb_trees:delete_smallest(CleanPriorityQueue),
            % Increment attended count and move to the next day.
            solve(CurrentDay + 1, MaxEndDay, RemainingEventsToStart, AttendedPriorityQueue, AttendedCount + 1, NewRefCounter)
    end.

remove_expired_events(CurrentDay, PQ) ->
    case gb_trees:is_empty(PQ) of
        true ->
            PQ;
        false ->
            % Get the event with the earliest end day.
            {{MinEndDay, _}, _} = gb_trees:smallest(PQ),
            if MinEndDay < CurrentDay ->
                % This event has expired, remove it and check the next smallest.
                remove_expired_events(CurrentDay, gb_trees:delete_smallest(PQ));
            true ->
                % The smallest event is still valid (MinEndDay >= CurrentDay),
                % so all other events in the queue are also valid.
                PQ
            end
    end.