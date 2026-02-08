-module(solution).
-export([countPalindromicSubsequences/1]).

-define(MOD, 1000000007).

countPalindromicSubsequences(S) ->
    N = length(S),
    if N == 0 ->
            0;
        true ->
            Chars = list_to_tuple(S), % For 0-indexed access using element/2

            % Precompute next_idx and prev_idx
            % NextIdx[Pos][Char_Code] = index of next Char_Code at or after Pos
            % PrevIdx[Pos][Char_Code] = index of prev Char_Code at or before Pos
            % Char_Code from 0 to 25 for 'a' to 'z'
            NextIdx = make_next_idx(N, Chars),
            PrevIdx = make_prev_idx(N, Chars),

            % dp table: dp[i][j]
            DP_init = init_dp_table(N),

            % Fill DP table
            ResultDP = fill_dp(N, Chars, NextIdx, PrevIdx, DP_init),

            array:get(N-1, array:get(0, ResultDP))
    end.

init_dp_table(N) ->
    DP = array:new([{fixed, true}, {size, N}]),
    lists:foldl(fun(I, AccDP) ->
                        array:set(I, array:new([{fixed, true}, {size, N}, {default, 0}]), AccDP)
                end, DP, lists:seq(0, N-1)).

get_char(Chars, Index) ->
    element(Index + 1, Chars).

get_char_code(Chars, Index) ->
    get_char(Chars, Index) - $a.

make_next_idx(N, Chars) ->
    FinalNextIdx = array:new([{fixed, true}, {size, N}]),

    lists:foldl(fun(K, AccFinalNextIdx) ->
                        PrevNextRow = if K < N-1 -> array:get(K+1, AccFinalNextIdx);
                                          true -> array:new([{fixed, true}, {size, 26}, {default, N}]) % Default for N-1
                                      end,

                        CurrentNextRow = lists:foldl(fun(C, AccRow) ->
                                                          array:set(C, array:get(C, PrevNextRow), AccRow)
                                                  end, array:new([{fixed, true}, {size, 26}]), lists:seq(0, 25)),

                        Char_Code = get_char_code(Chars, K),
                        UpdatedCurrentNextRow = array:set(Char_Code, K, CurrentNextRow),

                        array:set(K, UpdatedCurrentNextRow, AccFinalNextIdx)
                end, FinalNextIdx, lists:seq(N-1, 0, -1)).

make_prev_idx(N, Chars) ->
    FinalPrevIdx = array:new([{fixed, true}, {size, N}]),

    lists:foldl(fun(K, AccFinalPrevIdx) ->
                        PrevPrevRow = if K > 0 -> array:get(K-1, AccFinalPrevIdx);
                                          true -> array:new([{fixed, true}, {size, 26}, {default, -1}]) % Default for 0
                                      end,

                        CurrentPrevRow = lists:foldl(fun(C, AccRow) ->
                                                          array:set(C, array:get(C, PrevPrevRow), AccRow)
                                                  end, array:new([{fixed, true}, {size, 26}]), lists:seq(0, 25)),

                        Char_Code = get_char_code(Chars, K),
                        UpdatedCurrentPrevRow = array:set(Char_Code, K, CurrentPrevRow),

                        array:set(K, UpdatedCurrentPrevRow, AccFinalPrevIdx)
                end, FinalPrevIdx, lists:seq(0, N-1)).

fill_dp(N, Chars, NextIdx, PrevIdx, DP) ->
    lists:foldl(fun(Len, AccDP_Len) ->
                    lists:foldl(fun(I, AccDP_I) ->
                                        J = I + Len - 1,
                                        Char_I = get_char(Chars, I),
                                        Char_J = get_char(Chars, J),

                                        Val = if Len == 1 ->
                                                    1;
                                                Char_I /= Char_J ->
                                                    DP_I_plus_1_J = array:get(J, array:get(I+1, AccDP_I)),
                                                    DP_I_J_minus_1 = array:get(J-1, array:get(I, AccDP_I)),
                                                    DP_I_plus_1_J_minus_1 = array:get(J-1, array:get(I+1, AccDP_I)),
                                                    (DP_I_plus_1_J + DP_I_J_minus_1 - DP_I_plus_1_J_minus_1 + ?MOD) rem ?MOD;
                                                true -> % Char_I == Char_J
                                                    Char_Code = get_char_code(Chars, I),

                                                    L_val = array:get(Char_Code, array:get(I+1, NextIdx)),
                                                    R_val = array:get(Char_Code, array:get(J-1, PrevIdx)),

                                                    DP_I_plus_1_J_minus_1 = array:get(J-1, array:get(I+1, AccDP_I)),

                                                    if L_val > R_val -> % No other same char in between
                                                           (2 * DP_I_plus_1_J_minus_1 + 2) rem ?MOD;
                                                       L_val == R_val -> % Exactly one same char in between
                                                           (2 * DP_I_plus_1_J_minus_1 + 1) rem ?MOD;
                                                       true -> % L_val < R_val, multiple same chars in between
                                                           DP_L_plus_1_R_minus_1 = array:get(R_val-1, array:get(L_val+1, AccDP_I)),
                                                           (2 * DP_I_plus_1_J_minus_1 - DP_L_plus_1_R_minus_1 + ?MOD) rem ?MOD
                                                    end
                                        end,

                                        CurrentRow = array:get(I, AccDP_I),
                                        UpdatedRow = array:set(J, Val, CurrentRow),
                                        array:set(I, UpdatedRow, AccDP_I)
                                end, AccDP_Len, lists:seq(0, N - Len))
            end, DP, lists:seq(1, N)).