-module(solution).
-export([smallestRange/1]).

-include_lib("stdlib/include/gb_trees.hrl"). % Include for gb_trees

smallestRange(Nums) ->
    K = length(Nums),
    NumsArray = list_to_tuple(Nums), % Convert list of lists to tuple of lists for O(1) access

    % Initialize min-heap and current maximum element seen
    InitialHeap = gb_trees:empty(),
    InitialCurrentMax = -1000000000, % Smallest possible value is -10^5, use a sufficiently small number

    % Populate the min-heap with the first element from each list
    % Each element in the heap is stored as {Key, Value} where:
    % Key = ElementValue
    % Value = {ListIndex, ElementIndexInList} (both 0-indexed)
    {Heap, CurrentMax} = lists:foldl(
        fun(ListIdx, {AccHeap, AccCurrentMax}) ->
            List = element(ListIdx + 1, NumsArray), % Get the list (1-indexed access for tuple)
            FirstElement = hd(List), % Get the first element of the current list
            NewHeap = gb_trees:insert(FirstElement, {ListIdx, 0}, AccHeap), % Insert {Value, {ListIdx, 0}}
            NewCurrentMax = max(AccCurrentMax, FirstElement), % Update current maximum
            {NewHeap, NewCurrentMax}
        end,
        {InitialHeap, InitialCurrentMax},
        lists:seq(0, K - 1) % Iterate through list indices from 0 to K-1
    ),

    % Initialize variables for tracking the smallest range
    MinRangeStart = 0,
    MinRangeEnd = 2000000000, % Largest possible value is 10^5, use a sufficiently large number
    MinRangeDiff = MinRangeEnd - MinRangeStart + 1, % Initial difference, larger than any possible range

    % Start the main loop to find the smallest range
    loop(Heap, CurrentMax, MinRangeStart, MinRangeEnd, MinRangeDiff, NumsArray).

loop(Heap, CurrentMax, MinRangeStart, MinRangeEnd, MinRangeDiff, NumsArray) ->
    case gb_trees:is_empty(Heap) of
        true ->
            % If the heap is empty, all lists have been exhausted, return the best range found
            {MinRangeStart, MinRangeEnd};
        false ->
            % Extract the minimum element from the heap
            % gb_trees:delete_min returns {Key, Value, NewTree}
            {MinVal, {ListIdx, ElemIdx}, NewHeap} = gb_trees:delete_min(Heap),

            % Calculate the current range difference
            CurrentRangeDiff = CurrentMax - MinVal,

            % Update the smallest range if the current range is better
            {UpdatedMinRangeStart, UpdatedMinRangeEnd, UpdatedMinRangeDiff} =
                if
                    CurrentRangeDiff < MinRangeDiff ->
                        % Current range is strictly smaller
                        {MinVal, CurrentMax, CurrentRangeDiff};
                    CurrentRangeDiff == MinRangeDiff andalso MinVal < MinRangeStart ->
                        % Current range has the same size but starts earlier (lexicographically smaller)
                        {MinVal, CurrentMax, CurrentRangeDiff};
                    true ->
                        % Current range is not better
                        {MinRangeStart, MinRangeEnd, MinRangeDiff}
                end,

            % Get the list from NumsArray using its 0-indexed ListIdx
            List = element(ListIdx + 1, NumsArray),
            ListLen = length(List),

            % Check if there are more elements in the list from which MinVal was extracted
            if
                ElemIdx + 1 < ListLen ->
                    % Get the next element from this list
                    NextElem = lists:nth(ElemIdx + 2, List), % ElemIdx is 0-indexed, lists:nth is 1-indexed

                    % Insert the next element into the heap
                    UpdatedHeap = gb_trees:insert(NextElem, {ListIdx, ElemIdx + 1}, NewHeap),

                    % Update the overall maximum element seen
                    UpdatedCurrentMax = max(CurrentMax, NextElem),

                    % Continue the loop with the updated state
                    loop(UpdatedHeap, UpdatedCurrentMax, UpdatedMinRangeStart, UpdatedMinRangeEnd, UpdatedMinRangeDiff, NumsArray);
                true ->
                    % The current list is exhausted. We can no longer cover all K lists,
                    % so the loop terminates and we return the best range found so far.
                    {UpdatedMinRangeStart, UpdatedMinRangeEnd}
            end
    end.