-module(solution).
-export([solve/2]).

-include_lib("stdlib/include/array.hrl").

solve(S, K) ->
    N = length(S),
    MOD = 1000000007,

    % DpPrevK[i] stores dp[i][k-1], representing ways to select k-1 substrings from S[0...i-1]
    % DpSumPrevK[i] stores sum(dp[x][k-1] for x in [0...i]), representing prefix sums of DpPrevK
    % Initialize for k=0. Array indices are 0 to N.
    DpPrevK = array:new(N + 1, {default, 0}),
    DpSumPrevK = array:new(N + 1, {default, 0}),

    % Base case: dp[0][0] = 1 (1 way to select 0 substrings from an empty string)
    DpPrevK_0 = array:set(0, 1, DpPrevK),
    % Base case: dp_sum[0][0] = 1
    DpSumPrevK_0 = array:set(0, 1, DpSumPrevK),

    % Loop for CurrK from 1 to K
    % AccDpPrevK and AccDpSumPrevK are the 'previous k' arrays (for CurrK-1)
    % DpCurrK and DpSumCurrK are the 'current k' arrays (for CurrK)
    {FinalDpPrevK, _FinalDpSumPrevK} = lists:foldl(
        fun(CurrK, {AccDpPrevK, AccDpSumPrevK}) ->
            DpCurrK = array:new(N + 1, {default, 0}),
            DpSumCurrK = array:new(N + 1, {default, 0}),

            % Loop for I from 1 to N (I represents the length of the prefix S[0...I-1])
            % I is 1-indexed for string length, but 0-indexed for array access internally
            {FinalDpCurrK_i_loop, FinalDpSumCurrK_i_loop} = lists:foldl(
                fun(I, {InnerDpCurrK, InnerDpSumCurrK}) ->
                    % dp[I][CurrK] = dp[I-1][CurrK] (ways without ending a substring at S[I-1])
                    PrevDpCurrK_I_minus_1 = array:get(I - 1, InnerDpCurrK),
                    InnerDpCurrK_Updated = array:set(I, PrevDpCurrK_I_minus_1, InnerDpCurrK),

                    % Find p_start (0-indexed) for special substrings ending at S[I-1]
                    % S[I-1] is lists:nth(I, S) since lists:nth is 1-indexed
                    CharI_minus_1 = lists:nth(I, S), 
                    PStart_0_indexed = find_p_start(S, I - 1, CharI_minus_1), % returns 0-indexed start

                    % Calculate sum(dp[p][CurrK-1] for p in [PStart_0_indexed ... I-1])
                    % This is (dp_sum[I-1][CurrK-1] - dp_sum[PStart_0_indexed-1][CurrK-1])
                    WaysEndingAtI = array:get(I - 1, AccDpSumPrevK), % dp_sum[I-1][CurrK-1]
                    WaysEndingAtI_Adjusted = 
                        if PStart_0_indexed > 0 ->
                            (WaysEndingAtI - array:get(PStart_0_indexed - 1, AccDpSumPrevK) + MOD) rem MOD;
                        true ->
                            WaysEndingAtI
                        end,

                    % Add ways ending at S[I-1] to dp[I][CurrK]
                    CurrentDpCurrK_I = array:get(I, InnerDpCurrK_Updated),
                    FinalDpCurrK_I = (CurrentDpCurrK_I + WaysEndingAtI_Adjusted) rem MOD,
                    InnerDpCurrK_Updated_Final = array:set(I, FinalDpCurrK_I, InnerDpCurrK_Updated),

                    % Update dp_sum[I][CurrK]
                    PrevDpSumCurrK_I_minus_1 = array:get(I - 1, InnerDpSumCurrK),
                    FinalDpSumCurrK_I = (PrevDpSumCurrK_I_minus_1 + FinalDpCurrK_I) rem MOD,
                    InnerDpSumCurrK_Updated_Final = array:set(I, FinalDpSumCurrK_I, InnerDpSumCurrK),

                    {InnerDpCurrK_Updated_Final, InnerDpSumCurrK_Updated_Final}
                end,
                {DpCurrK, DpSumCurrK},
                lists:seq(1, N) % I goes from 1 to N
            ),
            % Update for next k iteration: current k becomes previous k
            {FinalDpCurrK_i_loop, FinalDpSumCurrK_i_loop} 
        end,
        {DpPrevK_0, DpSumPrevK_0}, % Initial accumulator for k=0
        lists:seq(1, K) % CurrK goes from 1 to K
    ).

    % The final answer is dp[N][K]
    array:get(N, FinalDpPrevK).

find_p_start(S, EndIdx_0_indexed, Char) ->
    P_0_indexed = EndIdx_0_indexed,
    find_p_start_loop(S, P_0_indexed, Char).

find_p_start_loop(S, P_0_indexed, Char) ->
    % Check if the character at S[P_0_indexed-1] is the same as Char
    % lists:nth(P_0_indexed, S) gets the character at 0-indexed position P_0_indexed-1
    if P_0_indexed > 0 andalso lists:nth(P_0_indexed, S) == Char -> 
        find_p_start_loop(S, P_0_indexed - 1, Char);
    true ->
        P_0_indexed % This is the 0-indexed start of the block
    end.