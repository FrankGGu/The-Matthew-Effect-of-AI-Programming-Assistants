-module(solution).
-export([findRightInterval/1]).

findRightInterval(Intervals) ->
    N = length(Intervals),
    if N == 0 ->
        [];
    true ->
        % 1. Augment intervals with original index: [{Start, End, OriginalIndex}, ...]
        AugmentedIntervals = lists:zipwith(fun([S, E], Idx) -> {S, E, Idx} end, Intervals, lists:seq(0, N - 1)),

        % 2. Create a list of {Start, OriginalIndex} tuples, sorted by Start time.
        % This list is then converted to an array for O(1) random access during binary search.
        SortedStartsAndIndicesList = lists:sort(fun({S1, _}, {S2, _}) -> S1 =< S2 end,
                                                lists:map(fun({S, _, Idx}) -> {S, Idx} end, AugmentedIntervals)),
        SortedStartsAndIndicesArray = array:from_list(SortedStartsAndIndicesList),

        % 3. Initialize results array with -1s.
        ResultsArray = array:new([{size, N}, {fixed, true}, {default, -1}]),

        % 4. Iterate through the original (augmented) intervals. For each interval,
        % perform a binary search on SortedStartsAndIndicesArray to find the right interval.
        FinalResultsArray = lists:foldl(fun({_S, E, OriginalIdx}, AccResultsArray) ->
                                            case binary_search(SortedStartsAndIndicesArray, E) of
                                                {ok, RightIntervalIdx} ->
                                                    array:set(OriginalIdx, RightIntervalIdx, AccResultsArray);
                                                not_found ->
                                                    AccResultsArray
                                            end
                                        end, ResultsArray, AugmentedIntervals),

        array:to_list(FinalResultsArray)
    end.

binary_search(SortedStartsAndIndicesArray, TargetEnd) ->
    Len = array:size(SortedStartsAndIndicesArray),
    binary_search_impl(SortedStartsAndIndicesArray, TargetEnd, 0, Len - 1, not_found).

binary_search_impl(SortedStartsAndIndicesArray, TargetEnd, Low, High, BestMatch) ->
    if
        Low > High ->
            BestMatch;
        true ->
            Mid = Low + (High - Low) div 2,
            {CurrentStart, CurrentIdx} = array:get(Mid, SortedStartsAndIndicesArray), % array:get is 0-based
            if
                CurrentStart >= TargetEnd ->
                    % CurrentStart is a potential candidate. Try to find an even smaller one on the left.
                    binary_search_impl(SortedStartsAndIndicesArray, TargetEnd, Low, Mid - 1, {ok, CurrentIdx});
                true ->
                    % CurrentStart is too small, need to look on the right.
                    binary_search_impl(SortedStartsAndIndicesArray, TargetEnd, Mid + 1, High, BestMatch)
            end
    end.