-module(solution).
-export([max_value/2]).

-include_lib("kernel/include/array.hrl").

max_value(Events, K) ->
    % Sort events by start day in ascending order.
    % If start days are equal, the order doesn't strictly matter for correctness
    % but a consistent sort helps with determinism.
    SortedEventsList = lists:sort(fun([S1,_,_], [S2,_,_]) -> S1 =< S2 end, Events),

    % Convert the sorted list of events into an array for O(1) indexed access.
    EventsArray = array:from_list(SortedEventsList),
    N = array:size(EventsArray),

    % Initialize an empty map for memoization.
    InitialMemo = maps:new(),

    % Call the recursive dynamic programming helper function.
    % It returns a tuple {ResultValue, FinalMemoMap}. We only need the ResultValue.
    {Result, _FinalMemo} = dp(0, K, EventsArray, N, InitialMemo),
    Result.

dp(Idx, Count, EventsArray, N, Memo) ->
    % Base cases:
    % If no events can be attended or all events have been considered.
    if
        Count == 0 -> {0, Memo};
        Idx >= N -> {0, Memo};
        true ->
            Key = {Idx, Count},
            % Check if this state has already been computed.
            case maps:find(Key, Memo) of
                {ok, Value} -> {Value, Memo}; % Return memoized value
                error ->
                    % Retrieve the current event's details.
                    % Events are stored as [StartDay, EndDay, Value].
                    {_Start, End, Value} = array:get(Idx, EventsArray),

                    % Option 1: Skip the current event.
                    % Move to the next event without decrementing Count.
                    {Val1, Memo1} = dp(Idx + 1, Count, EventsArray, N, Memo),

                    % Option 2: Attend the current event.
                    % Add its value and find the next valid event to attend.
                    % The next valid event must start after the current event ends.
                    NextIdx = find_next_event_idx(EventsArray, End, Idx + 1, N),

                    % Recurse for the remaining events and one less event allowed.
                    % Memo2 builds upon Memo1, ensuring all updates are carried forward.
                    {Val2_rec, Memo2} = dp(NextIdx, Count - 1, EventsArray, N, Memo1),
                    Val2 = Value + Val2_rec,

                    % The maximum value for the current state is the maximum of the two options.
                    Result = max(Val1, Val2),

                    % Store the computed result in the memoization map.
                    NewMemo = maps:put(Key, Result, Memo2),
                    {Result, NewMemo}
            end
    end.

find_next_event_idx(EventsArray, CurrentEndTime, Low, High) ->
    Ans = High, % Default answer if no event starts after CurrentEndTime
    L = Low,
    R = High - 1, % Adjust R to be the last valid index in the search space

    find_next_event_idx_loop(EventsArray, CurrentEndTime, L, R, Ans).

find_next_event_idx_loop(EventsArray, CurrentEndTime, L, R, Ans) ->
    if
        L > R -> Ans; % Search range is empty, return the current best answer
        true ->
            Mid = L + (R - L) div 2, % Calculate mid-point to prevent overflow
            {MidStart, _, _} = array:get(Mid, EventsArray), % Get start day of mid event

            if
                MidStart > CurrentEndTime ->
                    % This event starts after CurrentEndTime. It's a possible answer.
                    % Try to find an earlier one by searching in the left half.
                    find_next_event_idx_loop(EventsArray, CurrentEndTime, L, Mid - 1, Mid);
                true ->
                    % This event starts at or before CurrentEndTime.
                    % We need to look for events that start later, in the right half.
                    find_next_event_idx_loop(EventsArray, CurrentEndTime, Mid + 1, R, Ans)
            end
    end.