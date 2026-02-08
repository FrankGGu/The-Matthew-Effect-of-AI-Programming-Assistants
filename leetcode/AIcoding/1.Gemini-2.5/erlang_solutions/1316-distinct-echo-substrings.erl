-module(solution).
-export([distinct_echo_substrings/1]).

-define(P1, 31).
-define(M1, 1000000007).
-define(P2, 37).
-define(M2, 1000000009).

distinct_echo_substrings(Text) ->
    S = string:to_list(Text),
    N = length(S),

    if N < 2 ->
        0;
    true ->
        P1_powers = precompute_powers(?P1, N, ?M1),
        P2_powers = precompute_powers(?P2, N, ?M2),

        {H1, H2} = precompute_hashes(S, ?P1, ?M1, ?P2, ?M2),

        Sets = sets:new(),
        ResultSets = iterate_and_check(N, P1_powers, H1, ?M1, P2_powers, H2, ?M2, Sets),
        sets:size(ResultSets)
    end.

precompute_powers(P, N, M) ->
    Powers = array:new([{size, N + 1}]),
    Powers1 = array:set(0, 1, Powers),
    precompute_powers_loop(1, N, P, M, Powers1).

precompute_powers_loop(Idx, MaxIdx, P, M, AccPowers) when Idx =< MaxIdx ->
    PrevPower = array:get(Idx - 1, AccPowers),
    CurrentPower = (PrevPower * P) rem M,
    NewAccPowers = array:set(Idx, CurrentPower, AccPowers),
    precompute_powers_loop(Idx + 1, MaxIdx, P, M, NewAccPowers);
precompute_powers_loop(_Idx, _MaxIdx, _P, _M, AccPowers) ->
    AccPowers.

precompute_hashes(S, P1, M1, P2, M2) ->
    N = length(S),
    H1_arr = array:new([{size, N + 1}]),
    H2_arr = array:new([{size, N + 1}]),
    H1_arr_0 = array:set(0, 0, H1_arr),
    H2_arr_0 = array:set(0, 0, H2_arr),
    precompute_hashes_loop(1, N, S, P1, M1, H1_arr_0, P2, M2, H2_arr_0).

precompute_hashes_loop(Idx, MaxIdx, S, P1, M1, AccH1, P2, M2, AccH2) when Idx =< MaxIdx ->
    CharVal = lists:nth(Idx, S) - $a + 1,
    PrevH1 = array:get(Idx - 1, AccH1),
    CurrentH1 = (PrevH1 * P1 + CharVal) rem M1,
    NewAccH1 = array:set(Idx, CurrentH1, AccH1),

    PrevH2 = array:get(Idx - 1, AccH2),
    CurrentH2 = (PrevH2 * P2 + CharVal) rem M2,
    NewAccH2 = array:set(Idx, CurrentH2, AccH2),

    precompute_hashes_loop(Idx + 1, MaxIdx, S, P1, M1, NewAccH1, P2, M2, NewAccH2);
precompute_hashes_loop(_Idx, _MaxIdx, _S, _P1, _M1, AccH1, _P2, _M2, AccH2) ->
    {AccH1, AccH2}.

get_hash(StartIdx, EndIdx, H_arr, P_powers, M) ->
    Len = EndIdx - StartIdx + 1,
    Hash_J_plus_1 = array:get(EndIdx + 1, H_arr),
    Hash_I = array:get(StartIdx, H_arr),
    P_pow_Len = array:get(Len, P_powers),
    Result = (Hash_J_plus_1 - (Hash_I * P_pow_Len) rem M) rem M,
    if Result < 0 -> Result + M;
       true -> Result
    end.

iterate_and_check(N, P1_powers, H1, M1, P2_powers, H2, M2, AccSets) ->
    MaxK = N div 2,
    iterate_k(1, MaxK, N, P1_powers, H1, M1, P2_powers, H2, M2, AccSets).

iterate_k(K, MaxK, N, P1_powers, H1, M1, P2_powers, H2, M2, AccSets) when K =< MaxK ->
    SubstrLen = 2 * K,
    NewAccSets = iterate_i(0, N - SubstrLen, K, P1_powers, H1, M1, P2_powers, H2, M2, AccSets),
    iterate_k(K + 1, MaxK, N, P1_powers, H1, M1, P2_powers, H2, M2, NewAccSets);
iterate_k(_K, _MaxK, _N, _P1_powers, _H1, _M1, _P2_powers, _H2, _M2, AccSets) ->
    AccSets.

iterate_i(I, MaxI, K, P1_powers, H1, M1, P2_powers, H2, M2, AccSets) when I =< MaxI ->
    Hash1_A1 = get_hash(I, I + K - 1, H1, P1_powers, M1),
    Hash2_A1 = get_hash(I, I + K - 1, H2, P2_powers, M2),

    Hash1_A2 = get_hash(I + K, I + 2*K - 1, H1, P1_powers, M1),
    Hash2_A2 = get_hash(I + K, I + 2*K - 1, H2, P2_powers, M2),

    NewAccSets =
        if Hash1_A1 == Hash1_A2 andalso Hash2_A1 == Hash2_A2 ->
            FullSubstrLen = 2 * K,
            FullHash1 = get_hash(I, I + FullSubstrLen - 1, H1, P1_powers, M1),
            FullHash2 = get_hash(I, I + FullSubstrLen - 1, H2, P2_powers, M2),
            sets:add_element({FullHash1, FullHash2}, AccSets);
        true ->
            AccSets
        end,
    iterate_i(I + 1, MaxI, K, P1_powers, H1, M1, P2_powers, H2, M2, NewAccSets);
iterate_i(_I, _MaxI, _K, _P1_powers, _H1, _M1, _P2_powers, _H2, _M2, AccSets) ->
    AccSets.