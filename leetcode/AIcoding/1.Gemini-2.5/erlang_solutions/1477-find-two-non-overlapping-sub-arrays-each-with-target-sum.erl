-module(solution).
-export([minSumOfLengths/2]).

minSumOfLengths(Arr, Target) ->
    N = length(Arr),
    Infinity = 1_000_000, % A sufficiently large number representing infinity. Max possible length sum is 2*10^5.

    % Initial state for the fold: {CurrentSum, PrefixMap, DpMap, MinRes}
    % CurrentSum: The running prefix sum of elements processed so far.
    % PrefixMap: A map storing {Sum => Index} for all prefix sums encountered.
    % DpMap: A map storing {Index => MinLenLeft}, where MinLenLeft is the minimum
    %        length of a sub-array with sum 'Target' ending at or before 'Index'.
    % MinRes: The minimum sum of lengths of two non-overlapping sub-arrays found so far.
    InitialState = {0, maps:put(0, -1, maps:new()), maps:new(), Infinity},

    % Iterate through the array using a helper function that provides an index.
    % The foldl_with_index function applies a given function for each element
    % along with its index, accumulating a state.
    ResultState = foldl_with_index(
        fun(I, Val, {CurrentSum, PrefixMap, DpMap, MinRes}) ->
            NewCurrentSum = CurrentSum + Val,

            % Get the minimum length of a sub-array with target sum ending at or before index I-1.
            % This is used to update dp[I] and to find the first sub-array for min_res.
            PrevDpVal = if I > 0 andalso maps:is_key(I-1, DpMap) -> maps:get(I-1, DpMap); true -> Infinity end,

            DpValForCurrentSegment = Infinity, % Initialize min length of a sub-array ending at I with target sum.
            NewMinRes = MinRes, % Initialize the new minimum total length.

            % Check if a sub-array ending at the current index 'I' with 'Target' sum exists.
            % This is done by looking for (NewCurrentSum - Target) in the PrefixMap.
            if maps:is_key(NewCurrentSum - Target, PrefixMap) ->
                J = maps:get(NewCurrentSum - Target, PrefixMap), % 'J' is the index before the start of this segment.
                SegmentLen = I - J, % Length of the current sub-array (from index J+1 to I).

                DpValForCurrentSegment = SegmentLen,

                % If a valid previous sub-array (ending at index 'J' or before) exists
                % and its length is not Infinity (meaning a sub-array was found),
                % then we can form two non-overlapping sub-arrays.
                if J >= 0 andalso maps:is_key(J, DpMap) andalso maps:get(J, DpMap) =/= Infinity ->
                    % Update the overall minimum sum of lengths.
                    NewMinRes = min(MinRes, maps:get(J, DpMap) + SegmentLen);
                true ->
                    ok
                end;
            true ->
                ok
            end,

            % Update DpMap for the current index 'I'.
            % dp[I] is the minimum of dp[I-1] (min length ending before I)
            % and DpValForCurrentSegment (min length ending exactly at I).
            NewDpVal = min(PrevDpVal, DpValForCurrentSegment),
            NewDpMap = maps:put(I, NewDpVal, DpMap),

            % Update PrefixMap with the current sum and its index.
            NewPrefixMap = maps:put(NewCurrentSum, I, PrefixMap),

            % Return the updated state for the next iteration.
            {NewCurrentSum, NewPrefixMap, NewDpMap, NewMinRes}
        end,
        0, % Initial index for the first element (0-based).
        InitialState,
        Arr
    ),

    % Extract the final minimum result from the accumulated state.
    {_, _, _, FinalMinRes} = ResultState,

    % If FinalMinRes is still Infinity, no two such sub-arrays were found.
    if FinalMinRes =:= Infinity -> -1; true -> FinalMinRes end.

foldl_with_index(Fun, Idx, Acc, [H|T]) ->
    foldl_with_index(Fun, Idx + 1, Fun(Idx, H, Acc), T);
foldl_with_index(_Fun, _Idx, Acc, []) ->
    Acc.