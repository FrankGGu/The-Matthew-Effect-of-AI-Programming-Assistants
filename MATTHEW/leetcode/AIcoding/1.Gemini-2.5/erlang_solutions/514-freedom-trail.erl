-module(solution).
-export([find_rotate_steps/2]).

build_char_to_indices(RingBin) ->
    RingList = binary_to_list(RingBin),
    IndexedRing = lists:zip(RingList, lists:seq(0, length(RingList) - 1)),
    lists:foldl(
        fun({Char, Idx}, AccMap) ->
            maps:update_with(Char, fun(Indices) -> [Idx | Indices] end, [Idx], AccMap)
        end,
        maps:new(),
        IndexedRing
    ).

solve_memo(KIdx, RIdx, KeyTuple, RingLen, KeyLen, CharToIndices, Memo) ->
    case maps:find({KIdx, RIdx}, Memo) of
        {ok, Value} -> {Value, Memo}; % Return memoized value
        error ->
            if KIdx == KeyLen ->
                {0, Memo}; % Base case: all key characters typed, 0 more steps
            else
                TargetChar = element(KIdx + 1, KeyTuple), % element is 1-indexed
                PossibleRingIndices = maps:get(TargetChar, CharToIndices),

                % Fold over all possible next ring positions for the TargetChar
                {MinSteps, UpdatedMemoAfterFold} = lists:foldl(
                    fun(NextRIdx, {AccMinSteps, CurrentFoldMemo}) ->
                        % Calculate rotation cost from current RIdx to NextRIdx
                        Diff = abs(RIdx - NextRIdx),
                        CostRotate = min(Diff, RingLen - Diff),

                        % Recursively find steps for the rest of the key
                        {SubResult, MemoAfterSubCall} = solve_memo(KIdx + 1, NextRIdx, KeyTuple, RingLen, KeyLen, CharToIndices, CurrentFoldMemo),

                        % Total steps for this path: rotation + 1 (for pressing) + sub-problem result
                        Steps = CostRotate + 1 + SubResult,
                        {min(AccMinSteps, Steps), MemoAfterSubCall}
                    end,
                    {infinity, Memo}, % Initial accumulator: {infinity, current Memo}
                    PossibleRingIndices
                ),
                % Store the computed minimum steps in the memo and return
                {MinSteps, maps:put({KIdx, RIdx}, MinSteps, UpdatedMemoAfterFold)}
            end
    end.

find_rotate_steps(Ring, Key) ->
    RingList = binary_to_list(Ring),
    KeyList = binary_to_list(Key),

    RingLen = length(RingList),
    KeyLen = length(KeyList),

    CharToIndices = build_char_to_indices(Ring),
    KeyTuple = list_to_tuple(KeyList), % Convert key to tuple for O(1) access

    % Initial call: KIdx=0 (first key char), RIdx=0 (ring starts at index 0)
    {Result, _FinalMemo} = solve_memo(0, 0, KeyTuple, RingLen, KeyLen, CharToIndices, maps:new()),
    Result.