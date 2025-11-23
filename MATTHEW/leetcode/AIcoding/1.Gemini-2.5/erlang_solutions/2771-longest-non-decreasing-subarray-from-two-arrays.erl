-module(solution).
-export([longest_non_decreasing_subarray/2]).

longest_non_decreasing_subarray(Nums1, Nums2) ->
    % The problem constraints state N >= 1.
    % For N=1, the result is 1.
    % The initial call to solve handles this by passing the first elements
    % as Prev1, Prev2, and initial DP values as 1, with max_len as 1.
    % The base case for solve will then return 1 if N=1.
    solve(tl(Nums1), tl(Nums2), hd(Nums1), hd(Nums2), 1, 1, 1).

solve([], [], _Prev1, _Prev2, _PrevDP1, _PrevDP2, MaxLen) ->
    MaxLen;
solve([H1|T1], [H2|T2], Prev1, Prev2, PrevDP1, PrevDP2, MaxLen) ->
    % Calculate FinalCurrDP1 (length of longest non-decreasing subarray ending with H1)
    % It must be at least 1 (H1 itself).
    CurrDP1_FromPrev1 = if H1 >= Prev1 -> PrevDP1 + 1; true -> 0 end,
    CurrDP1_FromPrev2 = if H1 >= Prev2 -> PrevDP2 + 1; true -> 0 end,
    FinalCurrDP1 = max(1, max(CurrDP1_FromPrev1, CurrDP1_FromPrev2)),

    % Calculate FinalCurrDP2 (length of longest non-decreasing subarray ending with H2)
    % It must be at least 1 (H2 itself).
    CurrDP2_FromPrev1 = if H2 >= Prev1 -> PrevDP1 + 1; true -> 0 end,
    CurrDP2_FromPrev2 = if H2 >= Prev2 -> PrevDP2 + 1; true -> 0 end,
    FinalCurrDP2 = max(1, max(CurrDP2_FromPrev1, CurrDP2_FromPrev2)),

    % Update the overall maximum length found so far
    NewMaxLen = max(MaxLen, max(FinalCurrDP1, FinalCurrDP2)),

    % Recurse with the next elements, updating previous values
    solve(T1, T2, H1, H2, FinalCurrDP1, FinalCurrDP2, NewMaxLen).