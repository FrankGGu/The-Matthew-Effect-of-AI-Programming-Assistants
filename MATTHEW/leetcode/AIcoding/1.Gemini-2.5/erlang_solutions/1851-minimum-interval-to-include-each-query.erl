-module(solution).
-export([minInterval/2]).

minInterval(Intervals, Queries) ->
    % 1. Prepare queries: Add original index and sort by query value
    % Query format: {QueryValue, OriginalIndex}
    SortedQueries = lists:sort(fun({Q1, _}, {Q2, _}) -> Q1 =< Q2 end,
                               lists:zip(Queries, lists:seq(0, length(Queries) - 1))),

    % 2. Sort intervals by start point
    % Interval format: {L, R}
    SortedIntervals = lists:sort(fun({L1, _}, {L2, _}) -> L1 =< L2 end, Intervals),

    % 3. Initialize results array (will be updated by index)
    NumQueries = length(Queries),
    Results = array:new([{size, NumQueries}, {default, -1}]),

    % 4. Call helper function to process queries
    % Initial call: pass all sorted intervals and an empty heap
    process_queries(SortedQueries, SortedIntervals, gb_trees:empty(), Results).

process_queries([], _RemainingSortedIntervals, _MinHeap, Results) ->
    % All queries processed, convert array to list
    array:to_list(Results);
process_queries([{Q, OriginalIdx} | RestQueries], RemainingSortedIntervals, MinHeap, Results) ->
    % 4a. Add relevant intervals to heap
    % NewRemainingSortedIntervals are intervals whose L > Q
    {NewRemainingSortedIntervals, UpdatedMinHeap1} = add_intervals_to_heap(Q, RemainingSortedIntervals, MinHeap),

    % 4b. Remove expired intervals from heap
    UpdatedMinHeap2 = remove_expired_intervals(Q, UpdatedMinHeap1),

    % 4c. Find minimum length and update results
    UpdatedResults =
        case gb_trees:is_empty(UpdatedMinHeap2) of
            true -> Results;
            false ->
                {MinLength, _R} = gb_trees:smallest(UpdatedMinHeap2),
                array:set(OriginalIdx, MinLength, Results)
        end,

    % Recurse for next query
    process_queries(RestQueries, NewRemainingSortedIntervals, UpdatedMinHeap2, UpdatedResults).

add_intervals_to_heap(Q, [{L, R} | RestIntervals], MinHeap) ->
    if
        L =< Q ->
            Length = R - L + 1,
            NewMinHeap = gb_trees:insert({Length, R}, true, MinHeap),
            add_intervals_to_heap(Q, RestIntervals, NewMinHeap);
        true ->
            % Current interval's L > Q, so subsequent intervals will also have L > Q
            % Return the current interval and all subsequent ones as remaining
            {[{L, R} | RestIntervals], MinHeap}
    end;
add_intervals_to_heap(_Q, [], MinHeap) ->
    % No more intervals to add
    {[], MinHeap}.

remove_expired_intervals(Q, MinHeap) ->
    case gb_trees:is_empty(MinHeap) of
        true -> MinHeap;
        false ->
            {_Length, R} = gb_trees:smallest(MinHeap),
            if
                R < Q ->
                    % This interval has expired, remove it and check the next smallest
                    remove_expired_intervals(Q, gb_trees:delete_smallest(MinHeap));
                true ->
                    % Smallest interval has R >= Q, so it's valid.
                    % Any other interval in the heap (with larger length) will also be valid
                    % (or would have been removed if its R < Q).
                    MinHeap
            end
    end.