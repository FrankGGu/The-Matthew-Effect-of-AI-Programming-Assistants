-module(solution).
-export([shortestCommonSupersequence/2]).

shortestCommonSupersequence(Str1, Str2) ->
    N1 = length(Str1),
    N2 = length(Str2),

    Str1_tuple = list_to_tuple([0 | Str1]),
    Str2_tuple = list_to_tuple([0 | Str2]),

    DP = fill_dp_single_array(Str1_tuple, Str2_tuple, N1, N2),

    reconstruct_scs_single_array(Str1_tuple, Str2_tuple, N1, N2, DP, []).

idx(I, J, Cols) -> I * Cols + J.

fill_dp_single_array(Str1_tuple, Str2_tuple, N1, N2) ->
    DP_size = (N1 + 1) * (N2 + 1),
    DP = array:new(DP_size, {default, 0}),
    Cols = N2 + 1, 

    lists:foldl(fun(I, CurrentDP) ->
        lists:foldl(fun(J, InnerDP) ->
            Char1 = element(I, Str1_tuple),
            Char2 = element(J, Str2_tuple),

            PrevLCS = array:get(idx(I-1, J-1, Cols), InnerDP),
            LCS_i_minus_1_j = array:get(idx(I-1, J, Cols), InnerDP),
            LCS_i_j_minus_1 = array:get(idx(I, J-1, Cols), InnerDP),

            NewVal = if Char1 == Char2 ->
                         PrevLCS + 1;
                     true ->
                         max(LCS_i_minus_1_j, LCS_i_j_minus_1)
                     end,

            array:set(idx(I, J, Cols), NewVal, InnerDP)
        end, CurrentDP, lists:seq(1, N2))
    end, DP, lists:seq(1, N1)).

reconstruct_scs_single_array(Str1_tuple, Str2_tuple, I, J, DP, AccResult) ->
    Cols = N2 + 1, 

    if I == 0 andalso J == 0 ->
        lists:reverse(AccResult);
    I == 0 ->
        RemainingStr2 = [element(K, Str2_tuple) || K <- lists:seq(1, J)],
        lists:reverse(RemainingStr2 ++ AccResult);
    J == 0 ->
        RemainingStr1 = [element(K, Str1_tuple) || K <- lists:seq(1, I)],
        lists:reverse(RemainingStr1 ++ AccResult);
    true ->
        Char1 = element(I, Str1_tuple),
        Char2 = element(J, Str2_tuple),

        if Char1 == Char2 ->
            reconstruct_scs_single_array(Str1_tuple, Str2_tuple, I - 1, J - 1, DP, [Char1 | AccResult]);
        true ->
            LCS_i_minus_1_j = array:get(idx(I-1, J, Cols), DP),
            LCS_i_j_minus_1 = array:get(idx(I, J-1, Cols), DP),

            if LCS_i_minus_1_j > LCS_i_j_minus_1 ->
                reconstruct_scs_single_array(Str1_tuple, Str2_tuple, I - 1, J, DP, [Char1 | AccResult]);
            true ->
                reconstruct_scs_single_array(Str1_tuple, Str2_tuple, I, J - 1, DP, [Char2 | AccResult])
            end
        end
    end.