-module(solution).
-export([longestPalindromeSubsequence/2]).

longestPalindromeSubsequence(S, K) ->
    N = length(S),

    DP = array:new({N, N, K + 1}, 0),

    SArray = array:from_list(S),

    DP1 = fill_len1_base_cases(0, N - 1, K, DP),

    DPFinal = fill_dp(2, N, N, K, SArray, DP1),

    array:get({0, N - 1, K}, DPFinal).

fill_len1_base_cases(I, MaxI, K, DP) when I =< MaxI ->
    DP_updated = fill_len1_k_cases(I, 0, K, DP),
    fill_len1_base_cases(I + 1, MaxI, K, DP_updated);
fill_len1_base_cases(_, _, _, DP) ->
    DP.

fill_len1_k_cases(I, K_val, MaxK, DP) when K_val =< MaxK ->
    DP_updated = array:set({I, I, K_val}, 1, DP),
    fill_len1_k_cases(I, K_val + 1, MaxK, DP_updated);
fill_len1_k_cases(_, _, _, DP) ->
    DP.

fill_dp(Len, MaxLen, N, K, SArray, DP) when Len =< MaxLen ->
    DP_updated = fill_dp_for_len(0, N - Len, Len, N, K, SArray, DP),
    fill_dp(Len + 1, MaxLen, N, K, SArray, DP_updated);
fill_dp(_, _, _, _, _, DP) ->
    DP.

fill_dp_for_len(I, MaxI, Len, N, K, SArray, DP) when I =< MaxI ->
    J = I + Len - 1,
    DP_updated = fill_dp_for_len_i_j(I, J, Len, 0, K, SArray, DP),
    fill_dp_for_len(I + 1, MaxI, Len, N, K, SArray, DP_updated);
fill_dp_for_len(_, _, _, _, _, DP) ->
    DP.

fill_dp_for_len_i_j(I, J, Len, K_val, MaxK, SArray, DP) when K_val =< MaxK ->
    CharI = array:get(I, SArray),
    CharJ = array:get(J, SArray),

    CurrentMax = 0,

    MaxFromLeft = array:get({I + 1, J, K_val}, DP),
    MaxFromRight = array:get({I, J - 1, K_val}, DP),
    CurrentMax1 = max(MaxFromLeft, MaxFromRight),

    CostToMatch = if CharI == CharJ -> 0; true -> 1 end,

    CurrentMax2 = CurrentMax1,

    if K_val >= CostToMatch ->
        InnerLen = 0,
        if Len == 2 ->
            InnerLen = 0 
        else
            InnerLen = array:get({I + 1, J - 1, K_val - CostToMatch}, DP)
        end,
        CurrentMax2 = max(CurrentMax1, 2 + InnerLen)
    end,

    PrevKValMax = if K_val > 0 -> array:get({I, J, K_val - 1}, DP); true -> 0 end,
    FinalMax = max(CurrentMax2, PrevKValMax),

    DP_updated = array:set({I, J, K_val}, FinalMax, DP),
    fill_dp_for_len_i_j(I, J, Len, K_val + 1, MaxK, SArray, DP_updated);
fill_dp_for_len_i_j(_, _, _, _, _, _, DP) ->
    DP.