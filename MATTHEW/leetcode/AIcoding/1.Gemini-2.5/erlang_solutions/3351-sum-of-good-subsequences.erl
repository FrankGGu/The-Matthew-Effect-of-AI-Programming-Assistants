-module(solution).
-export([sum_of_good_subsequences/1]).

sum_of_good_subsequences(Nums) ->
    N = length(Nums),
    Mod = 1000000000 + 7,

    % If the input list is empty, there are no subsequences, so the sum of lengths is 0.
    if N == 0 ->
        0;
    true ->
        % dp[i] will store a tuple {SumLengths, CountSubsequences}
        % SumLengths: sum of lengths of all good subsequences ending with Nums[i]
        % CountSubsequences: count of all good subsequences ending with Nums[i]
        % Initialize dp array with N elements. Each element itself forms a good subsequence of length 1.
        % So, initial state for each element is {1, 1}.
        InitialDp = array:new(N, {1, 1}),

        % Convert Nums list to an array for O(1) access by index.
        NumsArray = array:from_list(Nums),

        % Start the dynamic programming computation.
        compute_dp(0, N, NumsArray, InitialDp, Mod)
    end.

compute_dp(CurrentIdx, N, NumsArray, AccDp, Mod) when CurrentIdx < N ->
    CurrentVal = array:get(CurrentIdx, NumsArray),

    % Initialize the sum of lengths and count of subsequences for CurrentVal.
    % The element itself forms a subsequence of length 1, count 1.
    CurrentSumLengths = 1,
    CurrentCountSubsequences = 1,

    % Iterate through all previous elements (from index 0 to CurrentIdx - 1).
    % For each previous element Nums[PrevIdx], check if CurrentVal is a multiple of Nums[PrevIdx].
    % If it is, then good subsequences ending at Nums[PrevIdx] can be extended by CurrentVal.
    {NewSumLengths, NewCountSubsequences} =
        lists:foldl(fun(PrevIdx, {SumL, CountS}) ->
                        PrevVal = array:get(PrevIdx, NumsArray),
                        if
                            CurrentVal rem PrevVal == 0 ->
                                % Get the DP values for the previous element.
                                {PrevSumL, PrevCountS} = array:get(PrevIdx, AccDp),

                                % When extending subsequences ending at PrevVal with CurrentVal:
                                % 1. The count of new subsequences added is PrevCountS.
                                % 2. The sum of lengths increases. Each of the PrevCountS subsequences
                                %    has its length increased by 1. So, the total increase is PrevCountS * 1.
                                %    The original sum of lengths for these subsequences was PrevSumL.
                                %    So, the new contribution to sum of lengths is PrevSumL + PrevCountS.
                                SumL_updated = (SumL + PrevSumL + PrevCountS) rem Mod,
                                CountS_updated = (CountS + PrevCountS) rem Mod,
                                {SumL_updated, CountS_updated}
                            true ->
                                % If CurrentVal is not a multiple of PrevVal, no extension is possible.
                                {SumL, CountS}
                        end
                end, {CurrentSumLengths, CurrentCountSubsequences}, lists:seq(0, CurrentIdx - 1)),

    % Store the computed DP values for the current index.
    UpdatedAccDp = array:set(CurrentIdx, {NewSumLengths, NewCountSubsequences}, AccDp),

    % Recurse for the next element.
    compute_dp(CurrentIdx + 1, N, NumsArray, UpdatedAccDp, Mod);

compute_dp(N, N, _NumsArray, FinalDp, Mod) ->
    % Sum up all the 'SumLengths' from the final DP array to get the total sum of lengths.
    TotalSumLengths = lists:foldl(fun(Idx, Acc) ->
                                          {SumL, _CountS} = array:get(Idx, FinalDp),
                                          (Acc + SumL) rem Mod
                                  end, 0, lists:seq(0, N - 1)),
    TotalSumLengths.