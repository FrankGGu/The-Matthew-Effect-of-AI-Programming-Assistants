-module(solution).
-export([solve/2]).

solve(S, K) ->
    count_at_most_k_distinct(S, K).

count_at_most_k_distinct(S, K) ->
    % S_suffix: The remaining part of the original string to be processed (Right pointer moves through this)
    % K: maximum number of distinct characters allowed in a substring
    % WindowQueue: queue of characters currently in the sliding window (oldest char at front)
    % FreqMap: map of character frequencies within the current window
    % TotalCount: accumulated count of valid substrings
    count_at_most_k_distinct_helper(S, K, queue:new(), #{}, 0).

count_at_most_k_distinct_helper([Char | RestS], K, WindowQueue, FreqMap, TotalCount) ->
    % Step 1: Expand the window by adding the current character 'Char'
    NewWindowQueue1 = queue:in(Char, WindowQueue),
    NewFreqMap1 = maps:update_with(Char, fun(V) -> V + 1 end, 1, FreqMap),

    % Step 2: Shrink the window from the left if the distinct character count exceeds K
    {FinalWindowQueue, FinalFreqMap} = 
        adjust_window(K, NewWindowQueue1, NewFreqMap1),

    % Step 3: Add the count of valid substrings ending at the current 'Right' position.
    % The number of valid substrings ending at the current 'Right' is the current window size.
    NewTotalCount = TotalCount + queue:len(FinalWindowQueue),

    % Step 4: Move to the next character (implicitly by processing RestS)
    count_at_most_k_distinct_helper(RestS, K, FinalWindowQueue, FinalFreqMap, NewTotalCount);
count_at_most_k_distinct_helper([], _K, _WindowQueue, _FreqMap, TotalCount) ->
    % Base case: All characters processed, return the total count
    TotalCount.

adjust_window(K, WindowQueue, FreqMap) ->
    DistinctCount = maps:size(FreqMap),
    if DistinctCount > K ->
        % If distinct count exceeds K, remove the character from the left of the window
        {value, LeftChar, RestWindowQueue} = queue:out(WindowQueue),
        NewFreqMap = maps:update_with(LeftChar, fun(V) -> V - 1 end, FreqMap),

        % If the frequency of LeftChar becomes 0, remove it from the FreqMap
        FinalFreqMap = case maps:get(LeftChar, NewFreqMap) of
                           0 -> maps:remove(LeftChar, NewFreqMap);
                           _ -> NewFreqMap
                       end,
        % Recursively adjust the window until the constraint is satisfied
        adjust_window(K, RestWindowQueue, FinalFreqMap);
    true ->
        % Window is valid, return its current state
        {WindowQueue, FreqMap}
    end.