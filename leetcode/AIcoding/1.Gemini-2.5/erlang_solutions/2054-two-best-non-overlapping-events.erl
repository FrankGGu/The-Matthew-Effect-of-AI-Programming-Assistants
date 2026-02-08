-module(solution).
-export([max_two_events/1]).

max_two_events(Events0) ->
    if Events0 == [] -> 0; true -> ok end,

    % Sort events by start time
    SortedEventsList = lists:sort(fun([S1,_,_],[S2,_,_]) -> S1 =< S2 end, Events0),
    N = length(SortedEventsList),

    % Convert to array for O(1) access
    SortedEvents = array:from_list(SortedEventsList),

    % Precompute suffix maximum values for single events.
    % SuffixMaxValues[i] stores the maximum value of any event from index i to N-1.
    SuffixMaxValues = compute_suffix_max_values(SortedEvents, N),

    % Iterate through each event, considering it as the first event of a potential pair
    % or as a standalone single event.
    lists:foldl(fun(Idx, AccMax) ->
        [S1, E1, V1] = array:get(Idx, SortedEvents),

        % Option 1: V1 is a single event. Update overall maximum.
        MaxOverall1 = max(AccMax, V1),

        % Option 2: V1 is the first event of a pair.
        % Find the best second event that starts after E1.
        % We search for an event in the range [Idx + 1, N - 1] whose start time > E1.
        J = binary_search_first_greater_than_start_time(SortedEvents, E1, Idx + 1, N - 1),

        MaxOverall2 = if
            J == -1 -> % No such second event found
                MaxOverall1;
            true ->
                % Max value from this event (V1) + best second event's value
                V1 + array:get(J, SuffixMaxValues)
        end,
        max(MaxOverall1, MaxOverall2)
    end, 0, lists:seq(0, N-1)).

compute_suffix_max_values(EventsArray, N) ->
    % Use foldr to iterate from right to left, building the list of suffix maximums.
    % {CurrentMax, AccList} tuple stores the maximum seen so far from the right,
    % and the accumulated list of suffix maximums (in reverse order).
    SuffixMaxListResult = lists:foldr(fun(Idx, {CurrentMax, AccList}) ->
        [_,_,V] = array:get(Idx, EventsArray),
        NewCurrentMax = max(V, CurrentMax),
        {NewCurrentMax, [NewCurrentMax | AccList]}
    end, {0, []}, lists:seq(N-1, 0, -1)), % Iterate from N-1 down to 0

    % Extract the list and convert it to an array.
    array:from_list(element(2, SuffixMaxListResult)).

binary_search_first_greater_than_start_time(EventsArray, TargetEndTime, Low, High) ->
    if Low > High ->
        -1; % Not found
    else
        Mid = Low + (High - Low) div 2,
        [S,_,_] = array:get(Mid, EventsArray),
        if S > TargetEndTime ->
            % Current Mid could be the answer, or an earlier one.
            % Try to find an even earlier one in the left half.
            PrevResult = binary_search_first_greater_than_start_time(EventsArray, TargetEndTime, Low, Mid - 1),
            if PrevResult == -1 -> Mid; true -> PrevResult end;
        else
            % S <= TargetEndTime, need to look in the right half.
            binary_search_first_greater_than_start_time(EventsArray, TargetEndTime, Mid + 1, High)
        end
    end.