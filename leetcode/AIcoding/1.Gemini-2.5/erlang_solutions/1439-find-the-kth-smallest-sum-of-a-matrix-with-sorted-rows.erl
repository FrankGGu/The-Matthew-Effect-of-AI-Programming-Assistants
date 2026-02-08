-module(solution).
-export([kthSmallest/2]).

make_zeros(N) -> lists:duplicate(N, 0).

list_get(List, Index) -> lists:nth(Index + 1, List).

list_update(List, Index, NewValue) ->
    lists:replace_nth(Index + 1, NewValue, List).

kthSmallest(Mat, K) ->
    M = length(Mat),
    N = length(hd(Mat)), % Assuming all rows have same length and are non-empty

    % Calculate initial sum (sum of first elements of each row)
    InitialSum = lists:foldl(fun(Row, Acc) -> Acc + hd(Row) end, 0, Mat),

    % Initial indices: [0, 0, ..., 0]
    InitialIndices = make_zeros(M),

    % Priority queue (min-heap): gb_trees stores {Sum, list_of_IndexLists}
    % The key is the sum, and the value is a list of index combinations that yield that sum.
    PQ = gb_trees:insert(InitialSum, [InitialIndices], gb_trees:empty()),

    % Visited set: sets:set(IndexList) to avoid processing the same index combination multiple times
    Visited = sets:add_element(InitialIndices, sets:new()),

    % Loop K times to find the Kth smallest sum
    kthSmallest_loop(Mat, M, N, K, PQ, Visited, 0).

kthSmallest_loop(Mat, M, N, K, PQ, Visited, Count) ->
    % Extract the smallest sum from the priority queue
    case gb_trees:smallest(PQ) of
        {MinSum, IndexLists} ->
            % Take one IndexList from the list associated with MinSum
            [CurrentIndices | RestIndexLists] = IndexLists,

            % Update PQ: if RestIndexLists is empty, delete MinSum key; otherwise, update with RestIndexLists
            NewPQ1 = if RestIndexLists == [] -> gb_trees:delete_any(MinSum, PQ);
                        true -> gb_trees:update(MinSum, RestIndexLists, PQ)
                     end,

            NewCount = Count + 1,
            if NewCount == K ->
                MinSum; % This is the Kth smallest sum
            else
                % Explore neighbors by incrementing one index at a time
                % Accumulator for foldl will be a tuple {CurrentPQ, CurrentVisited}
                {FinalPQ, FinalVisited} = lists:foldl(
                    fun(RowIdx, {AccPQ, AccVisited}) ->
                        CurrentRowIdxVal = list_get(CurrentIndices, RowIdx),

                        % Check if we can increment the index for this row
                        if CurrentRowIdxVal + 1 < N ->
                            % Create new indices by incrementing for RowIdx
                            NextIndices = list_update(CurrentIndices, RowIdx, CurrentRowIdxVal + 1),

                            % Check if this set of indices has already been visited
                            if not sets:is_element(NextIndices, AccVisited) ->
                                % Calculate new sum
                                OldVal = list_get(list_get(Mat, RowIdx), CurrentRowIdxVal),
                                NewVal = list_get(list_get(Mat, RowIdx), CurrentRowIdxVal + 1),
                                NextSum = MinSum - OldVal + NewVal,

                                % Add to Visited set
                                UpdatedVisited = sets:add_element(NextIndices, AccVisited),

                                % Add to PQ: if NextSum exists, append NextIndices to its list; else, insert new list
                                UpdatedPQ = gb_trees:update(NextSum, fun(OldList) -> [NextIndices | OldList] end, [NextIndices], AccPQ),
                                {UpdatedPQ, UpdatedVisited};
                            else
                                {AccPQ, AccVisited} % Already visited, no change to PQ or Visited
                            end;
                        else
                            {AccPQ, AccVisited} % Cannot increment this row's index, no change to PQ or Visited
                        end
                    end,
                    {NewPQ1, Visited}, % Initial accumulator for foldl
                    lists:seq(0, M - 1) % Iterate through each row index (0 to M-1)
                ),
                % Recurse for the next smallest sum
                kthSmallest_loop(Mat, M, N, K, FinalPQ, FinalVisited, NewCount)
            end;
        _ ->
            % This case should ideally not be reached if K is valid and Mat is non-empty.
            % It would indicate an empty priority queue before K elements are found.
            exit(error_empty_priority_queue)
    end.