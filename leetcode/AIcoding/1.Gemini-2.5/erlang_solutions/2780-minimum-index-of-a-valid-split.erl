-module(solution).
-export([solve/1]).

find_dominant(Nums) ->
    N = length(Nums),

    % Create a frequency map for all elements in Nums.
    FreqMap = lists:foldl(fun(X, Acc) -> maps:update_with(X, fun(Val) -> Val + 1 end, 1, Acc) end, maps:new(), Nums),

    % Iterate through the frequency map to find if any element is dominant.
    Dominant = lists:foldl(fun({K, V}, Acc) ->
                                   if V * 2 > N -> K; % Check if frequency > N/2
                                      true -> Acc
                                   end
                           end, undefined, maps:to_list(FreqMap)),

    % Return the dominant element and its frequency, or {undefined, 0}.
    {Dominant, maps:get(Dominant, FreqMap, 0)}.

solve(Nums) ->
    N = length(Nums),

    % Step 1: Find the global dominant element and its frequency for the entire array.
    % If there is no global dominant element, then no single element can be dominant
    % in both subarrays of any split. Thus, no valid split exists.
    {GlobalDominant, GlobalFreq} = find_dominant(Nums),

    if GlobalDominant == undefined ->
        -1; % No global dominant, so no valid split.
    true ->
        % Step 2: Iterate through all possible split points (index I from 0 to N-2).
        % For each split, check if the GlobalDominant is dominant in both the
        % left subarray (nums[0...I]) and the right subarray (nums[I+1...N-1]).
        % We use a tail-recursive helper function to achieve O(N) time complexity
        % by processing the list iteratively without repeated list indexing.
        find_split_optimized_rec(Nums, N, GlobalDominant, GlobalFreq, 0, 0)
    end.

find_split_optimized_rec([CurrentNum | RestNums], N, GlobalDominant, GlobalFreq, LeftFreqD, I) when I < N - 1 ->
    % Update the frequency of GlobalDominant in the left subarray.
    NewLeftFreqD = if CurrentNum == GlobalDominant -> LeftFreqD + 1; true -> LeftFreqD end,

    LeftLen = I + 1, % Length of the left subarray (nums[0...I]).
    RightLen = N - LeftLen, % Length of the right subarray (nums[I+1...N-1]).

    % Calculate the frequency of GlobalDominant in the right subarray.
    RightFreqD = GlobalFreq - NewLeftFreqD,

    % Check if GlobalDominant is dominant in both the left and right subarrays.
    % A dominant element's frequency must be strictly greater than half the subarray's length.
    if NewLeftFreqD * 2 > LeftLen andalso RightFreqD * 2 > RightLen ->
        I; % Found the minimum valid split index, return it.
    true ->
        % If not a valid split, continue to the next index.
        find_split_optimized_rec(RestNums, N, GlobalDominant, GlobalFreq, NewLeftFreqD, I + 1)
    end;

find_split_optimized_rec(_, _, _, _, _, _) ->
    -1. % No valid split index found.