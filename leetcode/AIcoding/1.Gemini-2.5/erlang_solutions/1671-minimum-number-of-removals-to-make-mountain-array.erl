-module(solution).
-export([minimumMountainRemovals/1]).

minimumMountainRemovals(Nums) ->
    N = length(Nums),
    % According to problem constraints, N will always be >= 3.
    % If N < 3, a mountain array cannot be formed, so all elements would be removed or kept.
    % However, the problem states N >= 3, so this check is technically not needed for valid inputs.
    % For N >= 3, we proceed with the DP approach.

    DpInc = calculate_dp_inc(Nums),
    DpDec = calculate_dp_dec(Nums),

    MaxMountainLen = find_max_mountain_len(DpInc, DpDec, 0), % Initialize max length to 0

    N - MaxMountainLen.

calculate_dp_inc(Nums) ->
    calculate_dp_inc_recursive(Nums, [], []).

calculate_dp_inc_recursive([], AccDpInc, _) ->
    lists:reverse(AccDpInc); % Reverse to get the correct order
calculate_dp_inc_recursive([H | T], AccDpInc, ProcessedNums) ->
    % Calculate LIS ending at H
    MaxLenForH = 1, % Minimum LIS length is 1 (the element itself)
    NewMaxLenForH = calculate_lis_for_element(H, ProcessedNums, AccDpInc, MaxLenForH),

    % Add the calculated length to the accumulator and continue with the rest of the list
    calculate_dp_inc_recursive(T, [NewMaxLenForH | AccDpInc], [H | ProcessedNums]).

calculate_lis_for_element(CurrentVal, ProcessedNums, AccDpInc, AccMaxLen) ->
    % ProcessedNums and AccDpInc are in reversed order, corresponding to elements before CurrentVal
    calculate_lis_for_element_iter(CurrentVal, ProcessedNums, AccDpInc, AccMaxLen).

calculate_lis_for_element_iter(_, [], [], AccMaxLen) ->
    AccMaxLen;
calculate_lis_for_element_iter(CurrentVal, [PrevVal | RestProcessed], [PrevLen | RestAccDpInc], AccMaxLen) ->
    NewAccMaxLen = if
        PrevVal < CurrentVal ->
            % If PrevVal is smaller, CurrentVal can extend the LIS ending at PrevVal
            max(AccMaxLen, PrevLen + 1);
        true ->
            AccMaxLen
    end,
    calculate_lis_for_element_iter(CurrentVal, RestProcessed, RestAccDpInc, NewAccMaxLen).

calculate_dp_dec(Nums) ->
    NumsRev = lists:reverse(Nums),
    DpDecRev = calculate_dp_inc(NumsRev), % LIS on reversed list
    lists:reverse(DpDecRev). % Reverse back to original order for DpDec

find_max_mountain_len(DpInc, DpDec, AccMaxMountainLen) ->
    find_max_mountain_len_recursive(DpInc, DpDec, AccMaxMountainLen).

find_max_mountain_len_recursive([], [], AccMaxMountainLen) ->
    AccMaxMountainLen;
find_max_mountain_len_recursive([IncLen | TInc], [DecLen | TDec], AccMaxMountainLen) ->
    CurrentMountainLen = if
        IncLen > 1 andalso DecLen > 1 -> % Both sides must have at least one element
            IncLen + DecLen - 1; % Subtract 1 because the peak element is counted in both LIS and LDS
        true ->
            0 % Not a valid peak for a mountain array
    end,

    NewAccMaxMountainLen = max(AccMaxMountainLen, CurrentMountainLen),

    find_max_mountain_len_recursive(TInc, TDec, NewAccMaxMountainLen).