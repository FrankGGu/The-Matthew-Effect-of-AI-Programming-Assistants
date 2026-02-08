-module(solution).
-export([incremovableSubarrays/1]).

incremovableSubarrays(Nums) ->
    N = length(Nums),

    % Initialize PrefixOkArray: PrefixOkArray[k] is true if Nums[0..k-1] is strictly increasing.
    % k is length, ranging from 0 to N. Array size N+1.
    % Use Erlang's array module for O(1) access.
    PrefixOkArray = array:new([{fixed, true}, {size, N + 1}, {default, false}]),
    PrefixOkArray1 = array:set(0, true, PrefixOkArray), % Empty prefix (length 0) is strictly increasing

    PrefixOkArray2 = calculate_prefix_ok(1, N, Nums, PrefixOkArray1),

    % Initialize SuffixOkArray: SuffixOkArray[k] is true if Nums[N-k..N-1] is strictly increasing.
    % k is length, ranging from 0 to N. Array size N+1.
    SuffixOkArray = array:new([{fixed, true}, {size, N + 1}, {default, false}]),
    SuffixOkArray1 = array:set(0, true, SuffixOkArray), % Empty suffix (length 0) is strictly increasing

    SuffixOkArray2 = calculate_suffix_ok(1, N, Nums, SuffixOkArray1),

    % Iterate through all possible start indices (IStart) of the removed subarray.
    % IStart ranges from 0 to N-1.
    TotalCount = calculate_incremovable_subarrays(0, N - 1, N, Nums, PrefixOkArray2, SuffixOkArray2, 0),
    TotalCount.

calculate_prefix_ok(K, N, Nums, AccPrefixOkArray) when K =< N ->
    PrevOk = array:get(K - 1, AccPrefixOkArray),
    CurrentOk = 
        if
            PrevOk andalso K >= 2 -> % Nums[0..K-2] is increasing, check Nums[K-2] < Nums[K-1]
                % lists:nth is 1-based, so Nums[X] (0-indexed) is lists:nth(X+1, Nums)
                lists:nth(K - 1, Nums) < lists:nth(K, Nums);
            PrevOk andalso K == 1 -> % Nums[0] (length 1) is increasing
                true;
            true -> % PrevOk is false, so CurrentOk must be false
                false
        end,
    NewAccPrefixOkArray = array:set(K, CurrentOk, AccPrefixOkArray),
    calculate_prefix_ok(K + 1, N, Nums, NewAccPrefixOkArray);
calculate_prefix_ok(_K, _N, _Nums, AccPrefixOkArray) ->
    AccPrefixOkArray.

calculate_suffix_ok(K, N, Nums, AccSuffixOkArray) when K =< N ->
    PrevOk = array:get(K - 1, AccSuffixOkArray),
    CurrentOk = 
        if
            PrevOk andalso K >= 2 -> % Nums[N-K+1 .. N-1] is increasing, check Nums[N-K] < Nums[N-K+1]
                % lists:nth is 1-based, so Nums[X] (0-indexed) is lists:nth(X+1, Nums)
                lists:nth(N - K + 1, Nums) < lists:nth(N - K + 2, Nums);
            PrevOk andalso K == 1 -> % Nums[N-1] (length 1) is increasing
                true;
            true -> % PrevOk is false, so CurrentOk must be false
                false
        end,
    NewAccSuffixOkArray = array:set(K, CurrentOk, AccSuffixOkArray),
    calculate_suffix_ok(K + 1, N, Nums, NewAccSuffixOkArray);
calculate_suffix_ok(_K, _N, _Nums, AccSuffixOkArray) ->
    AccSuffixOkArray.

calculate_incremovable_subarrays(IStart, NMinus1, N, Nums, PrefixOkArray, SuffixOkArray, AccCount) when IStart =< NMinus1 ->
    % Check if the prefix Nums[0..IStart-1] is strictly increasing.
    % IStart here represents the length of the prefix.
    PrefixIsOk = array:get(IStart, PrefixOkArray),

    if
        not PrefixIsOk ->
            AccCount; % If prefix is not increasing, no further IStart values will work, so we can stop.
        true ->
            % For the current IStart, iterate through all possible JEnd (end index of the removed subarray).
            % JEnd ranges from IStart to N-1.
            InnerCount = calculate_incremovable_subarrays_inner(IStart, IStart, NMinus1, N, Nums, PrefixOkArray, SuffixOkArray, 0),
            calculate_incremovable_subarrays(IStart + 1, NMinus1, N, Nums, PrefixOkArray, SuffixOkArray, AccCount + InnerCount)
    end;
calculate_incremovable_subarrays(_IStart, _NMinus1, _N, _Nums, _PrefixOkArray, _SuffixOkArray, AccCount) ->
    AccCount.

calculate_incremovable_subarrays_inner(IStart, JEnd, NMinus1, N, Nums, PrefixOkArray, SuffixOkArray, AccInnerCount) when JEnd =< NMinus1 ->
    % Calculate the length of the suffix Nums[JEnd+1..N-1].
    SuffixLen = N - (JEnd + 1),
    SuffixIsOk = array:get(SuffixLen, SuffixOkArray),

    if
        not SuffixIsOk ->
            % If suffix is not increasing, this JEnd is not valid, try next JEnd.
            calculate_incremovable_subarrays_inner(IStart, JEnd + 1, NMinus1, N, Nums, PrefixOkArray, SuffixOkArray, AccInnerCount);
        true ->
            Valid = 
                if
                    IStart > 0 andalso JEnd < NMinus1 -> % Both prefix and suffix are non-empty
                        % Check Nums[IStart-1] < Nums[JEnd+1]
                        % Nums[IStart-1] (0-indexed) is lists:nth(IStart, Nums)
                        % Nums[JEnd+1] (0-indexed) is lists:nth(JEnd+2, Nums)
                        lists:nth(IStart, Nums) < lists:nth(JEnd + 2, Nums);
                    true -> % At least one of the parts (prefix or suffix) is empty, so no comparison needed.
                        true
                end,

            NewAccInnerCount = if Valid -> AccInnerCount + 1; true -> AccInnerCount end,
            calculate_incremovable_subarrays_inner(IStart, JEnd + 1, NMinus1, N, Nums, PrefixOkArray, SuffixOkArray, NewAccInnerCount)
    end;
calculate_incremovable_subarrays_inner(_IStart, _JEnd, _NMinus1, _N, _Nums, _PrefixOkArray, _SuffixOkArray, AccInnerCount) ->
    AccInnerCount.