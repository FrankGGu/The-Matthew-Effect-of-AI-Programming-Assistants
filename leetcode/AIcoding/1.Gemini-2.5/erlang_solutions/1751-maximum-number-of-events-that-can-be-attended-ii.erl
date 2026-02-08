-module(solution).
-export([max_value/2]).

max_value(Events, K) ->
    % Sort events by start_day. If start_day is the same, order doesn't strictly matter for correctness
    % but consistent ordering can help. Default sort is fine.
    SortedEvents = lists:sort(fun([S1,_,_], [S2,_,_]) -> S1 < S2 end, Events),
    N = length(SortedEvents),

    % Convert the list of events to a tuple for O(1) access by index.
    % This is crucial for performance with N up to 1000.
    EventsTuple = list_to_tuple(SortedEvents),

    % Initialize an empty map for memoization.
    % The keys will be {Idx, K_left} and values will be the max value.
    Memo = maps:new(),

    % Call the recursive solver. The solver returns {Result, UpdatedMemo}.
    {Result, _FinalMemo} = solve(0, K, EventsTuple, N, Memo),
    Result.

solve(_Idx, K_left, _EventsTuple, _N, Memo) when K_left == 0 ->
    {0, Memo};
solve(Idx, _K_left, _EventsTuple, N, Memo) when Idx == N ->
    {0, Memo};
solve(Idx, K_left, EventsTuple, N, Memo) ->
    case maps:find({Idx, K_left}, Memo) of
        {ok, Result} -> 
            % If already computed, return the stored result and the current memo map.
            {Result, Memo};
        _ ->
            % Option 1: Don't attend the current event (at Idx).
            % Move to the next event, K_left remains the same.
            % Memo_after_option1 will contain results from this subproblem.
            {Option1_Result, Memo_after_option1} = solve(Idx + 1, K_left, EventsTuple, N, Memo),

            % Option 2: Attend the current event (at Idx).
            % Get the details of the current event.
            [_S, E, V] = element(Idx + 1, EventsTuple), % element is 1-based

            % Find the index of the next valid event that starts after the current event ends.
            % This uses binary search for efficiency.
            NextIdx = find_next_event_idx(E, Idx + 1, EventsTuple, N),

            % Recursively solve for the remaining events and K_left - 1.
            % Pass Memo_after_option1 to ensure all previous computations are available.
            {Option2_Rest_Result, Memo_after_option2} = solve(NextIdx, K_left - 1, EventsTuple, N, Memo_after_option1),
            Option2_Result = V + Option2_Rest_Result,

            % The maximum value is the greater of the two options.
            Result = max(Option1_Result, Option2_Result),

            % Store the computed result in the memo map.
            UpdatedMemo = maps:put({Idx, K_left}, Result, Memo_after_option2),
            {Result, UpdatedMemo}
    end.

find_next_event_idx(CurrentEnd, Low, EventsTuple, N) ->
    % Initial call for binary search. 'N' is the default answer if no suitable event is found.
    find_next_event_idx_bs(CurrentEnd, Low, N - 1, EventsTuple, N, N).

find_next_event_idx_bs(_CurrentEnd, Low, High, _EventsTuple, _N, Ans) when Low > High ->
    Ans; % Search range exhausted, return the best candidate.
find_next_event_idx_bs(CurrentEnd, Low, High, EventsTuple, N, Ans) ->
    Mid = Low + (High - Low) div 2, % Calculate mid index.
    [S, _E, _V] = element(Mid + 1, EventsTuple), % Get start day of event at Mid.

    if
        S > CurrentEnd ->
            % This event starts after CurrentEnd. It's a potential candidate.
            % Try to find an earlier one by searching in the left half.
            find_next_event_idx_bs(CurrentEnd, Low, Mid - 1, EventsTuple, N, Mid);
        true ->
            % This event starts on or before CurrentEnd. It's not valid.
            % Search in the right half for a valid event.
            find_next_event_idx_bs(CurrentEnd, Mid + 1, High, EventsTuple, N, Ans)
    end.