-module(burst_balloons).
-export([max_coins/1]).

max_coins(Nums) ->
    PaddedNumsList = [1] ++ Nums ++ [1],
    PaddedArray = array:from_list(PaddedNumsList),
    PaddedN = array:size(PaddedArray),

    InitialDP = #{},

    FinalDP = solve_dp_len(2, PaddedN, PaddedArray, InitialDP),

    map:get({0, PaddedN - 1}, FinalDP, 0).

solve_dp_len(Len, MaxLen, PaddedArray, CurrentDP) when Len > MaxLen ->
    CurrentDP;
solve_dp_len(Len, MaxLen, PaddedArray, CurrentDP) ->
    MaxI = array:size(PaddedArray) - Len - 1,
    DP_after_i = solve_dp_i(0, MaxI, Len, PaddedArray, CurrentDP),
    solve_dp_len(Len + 1, MaxLen, PaddedArray, DP_after_i).

solve_dp_i(I, MaxI, Len, PaddedArray, CurrentDP) when I > MaxI ->
    CurrentDP;
solve_dp_i(I, MaxI, Len, PaddedArray, CurrentDP) ->
    J = I + Len,
    MaxK = J - 1,
    DP_after_k = solve_dp_k(I + 1, MaxK, I, J, PaddedArray, CurrentDP),
    solve_dp_i(I + 1, MaxI, Len, PaddedArray, DP_after_k).

solve_dp_k(K, MaxK, I, J, PaddedArray, CurrentDP) when K > MaxK ->
    CurrentDP;
solve_dp_k(K, MaxK, I, J, PaddedArray, CurrentDP) ->
    ValI = array:get(I, PaddedArray),
    ValK = array:get(K, PaddedArray),
    ValJ = array:get(J, PaddedArray),

    Coins = ValI * ValK * ValJ,

    PrevDP_IK = map:get({I, K}, CurrentDP, 0),
    PrevDP_KJ = map:get({K, J}, CurrentDP, 0),

    CurrentTotalCoins = PrevDP_IK + Coins + PrevDP_KJ,

    CurrentMaxForIJ = map:get({I, J}, CurrentDP, 0),

    NewMaxForIJ = max(CurrentMaxForIJ, CurrentTotalCoins),

    UpdatedDP = map:put({I, J}, NewMaxForIJ, CurrentDP),

    solve_dp_k(K + 1, MaxK, I, J, PaddedArray, UpdatedDP).