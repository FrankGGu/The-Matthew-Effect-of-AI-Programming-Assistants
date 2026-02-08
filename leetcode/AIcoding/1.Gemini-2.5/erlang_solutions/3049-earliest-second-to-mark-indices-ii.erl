-module(solution).
-export([earliestSecondToMarkIndices/2]).

earliestSecondToMarkIndices(Nums, ChangeIndices) ->
    N = length(Nums),
    M = length(ChangeIndices),

    % Convert Nums to an array for O(1) access
    InitialNumsArray = array:from_list(Nums),

    % Calculate the total decrement needed across all indices
    NeededDecrement = array_sum(InitialNumsArray),

    % Convert ChangeIndices to an array for O(1) access
    ChangeIndicesArray = array:from_list(ChangeIndices),

    % Binary search range for T (the earliest second)
    % Minimum T: N (at least N operations are needed to mark N indices)
    % Maximum T: M (all available operations)
    Low = N,
    High = M,

    % Binary search implementation
    BinarySearch = fun BS(L, H, Ans) ->
        if
            L > H -> Ans;
            true ->
                Mid = L + (H - L) div 2,
                case check(Mid, N, InitialNumsArray, ChangeIndicesArray, NeededDecrement) of
                    true -> BS(L, Mid - 1, Mid); % Mid is a possible answer, try smaller
                    false -> BS(Mid + 1, H, Ans) % Mid is not possible, try larger
                end
        end
    end,
    BinarySearch(Low, High, -1). % -1 indicates no solution found, but problem guarantees one.

check(T, N, InitialNumsArray, ChangeIndicesArray, NeededDecrement) ->
    % 1. Determine the latest operation time for each index up to second T
    %    This operation will be the one used to "mark" the index.
    LastOpTime = array:new([{size, N + 1}, {default, 0}]), % 1-indexed for indices
    LastOpTimeRef = lists:foldl(
        fun(S, Acc) ->
            [Idx, _Val] = array:get(S-1, ChangeIndicesArray), % S-1 for 0-indexed array
            array:set(Idx, S, Acc)
        end,
        LastOpTime,
        lists:seq(1, T)
    ),

    % 2. Check if all N indices have at least one operation up to T
    %    If any index has no operation, it cannot be marked.
    AllMarkable = lists:all(
        fun(Idx) -> array:get(Idx, LastOpTimeRef) /= 0 end,
        lists:seq(1, N)
    ),
    if not AllMarkable -> false; true -> ok end,

    % 3. Calculate the number of operations that can be used for decrementing.
    %    Total operations available up to T are T.
    %    N operations are used for marking (one for each index).
    %    So, T - N operations are "free" slots that can be used for decrementing.
    MaxDecrementOpsAllowed = T - N,
    if MaxDecrementOpsAllowed < 0 -> false; true -> ok end, % Not enough slots for marking

    % Use a min-priority queue (erl_heap) to keep track of the largest 'val's
    % from operations that can contribute to decrementing.
    PQ = erl_heap:new(),
    CurrentDecrementSum = 0,

    {_FinalPQ, FinalCurrentDecrementSum} = lists:foldl(
        fun(S, {AccPQ, AccSum}) ->
            [Idx, Val] = array:get(S-1, ChangeIndicesArray), % S-1 for 0-indexed array

            IsLastOpForIdx = (array:get(Idx, LastOpTimeRef) == S),
            NumValForIdx = array:get(Idx-1, InitialNumsArray), % Idx-1 for 0-indexed Nums array

            if
                % If this is the designated marking operation for an index
                % that initially has nums[idx-1] == 0, it's a "pure marking" op.
                % It doesn't contribute to the decrement sum.
                IsLastOpForIdx andalso NumValForIdx == 0 ->
                    {AccPQ, AccSum};
                true ->
                    % This operation can potentially contribute to decrementing.
                    % Add its 'val' to the priority queue.
                    NewPQ = erl_heap:insert(Val, AccPQ),
                    NewSum = AccSum + Val,

                    % If the PQ size exceeds the allowed number of decrementing operations,
                    % remove the smallest 'val' to keep only the largest ones.
                    if
                        erl_heap:size(NewPQ) > MaxDecrementOpsAllowed ->
                            {MinVal, PQWithoutMin} = erl_heap:delete_min(NewPQ),
                            {PQWithoutMin, NewSum - MinVal};
                        true ->
                            {NewPQ, NewSum}
                    end
            end
        end,
        {PQ, CurrentDecrementSum},
        lists:seq(1, T)
    ),

    % Check if the sum of 'val's from the selected decrementing operations
    % is sufficient to reduce all initial nums values to zero.
    FinalCurrentDecrementSum >= NeededDecrement.

array_sum(Arr) ->
    array:foldl(fun(X, Sum) -> Sum + X end, 0, Arr).