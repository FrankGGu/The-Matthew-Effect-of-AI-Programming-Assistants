-module(solution).
-export([longestCommonSubpath/2]).

-define(P1, 100003).
-define(M1, 1000000007).
-define(P2, 100007).
-define(M2, 1000000009).

longestCommonSubpath(_N, Paths) ->
    MinLen = lists:foldl(fun(Path, Acc) -> min(length(Path), Acc) end, 100001, Paths),

    %% Convert paths to arrays for O(1) access
    Paths_arr = [array:from_list(P) || P <- Paths],

    %% Precompute powers for hashing: PowP[k] stores P^k mod M
    PowP1_M1_list = precompute_powers_list(?P1, ?M1, MinLen),
    PowP2_M2_list = precompute_powers_list(?P2, ?M2, MinLen),
    PowP1_M1 = array:from_list(PowP1_M1_list), 
    PowP2_M2 = array:from_list(PowP2_M2_list),

    binary_search(0, MinLen, Paths_arr, PowP1_M1, PowP2_M2).

precompute_powers_list(P, M, MaxLen) ->
    precompute_powers_acc(P, M, MaxLen, 1, [1]).

precompute_powers_acc(_P, _M, -1, _CurrentPower, Acc) -> lists:reverse(Acc);
precompute_powers_acc(P, M, N, CurrentPower, Acc) ->
    NextPower = (CurrentPower * P) rem M,
    precompute_powers_acc(P, M, N - 1, NextPower, [NextPower | Acc]).

binary_search(Low, High, Paths_arr, PowP1_M1, PowP2_M2) ->
    binary_search_acc(Low, High, 0, Paths_arr, PowP1_M1, PowP2_M2).

binary_search_acc(Low, High, Ans, Paths_arr, PowP1_M1, PowP2_M2) when Low > High -> Ans;
binary_search_acc(Low, High, Ans, Paths_arr, PowP1_M1, PowP2_M2) ->
    Mid = Low + (High - Low) div 2,
    case check(Mid, Paths_arr, PowP1_M1, PowP2_M2) of
        true ->
            binary_search_acc(Mid + 1, High, Mid, Paths_arr, PowP1_M1, PowP2_M2);
        false ->
            binary_search_acc(Low, Mid - 1, Ans, Paths_arr, PowP1_M1, PowP2_M2)
    end.

check(L, Paths_arr, PowP1_M1, PowP2_M2) ->
    case L of
        0 -> true;
        _ ->
            [FirstPath_arr | RestPaths_arr] = Paths_arr,
            CommonHashes = get_hashes(FirstPath_arr, L, PowP1_M1, PowP2_M2),
            check_paths(RestPaths_arr, L, CommonHashes, PowP1_M1, PowP2_M2)
    end.

check_paths([], _L, CommonHashes, _PowP1_M1, _PowP2_M2) ->
    not sets:is_empty(CommonHashes);
check_paths([Path_arr | Rest], L, CommonHashes, PowP1_M1, PowP2_M2) ->
    CurrentPathHashes = get_hashes(Path_arr, L, PowP1_M1, PowP2_M2),
    NewCommonHashes = sets:intersection(CommonHashes, CurrentPathHashes),
    case sets:is_empty(NewCommonHashes) of
        true -> false;
        false -> check_paths(Rest, L, NewCommonHashes, PowP1_M1, PowP2_M2)
    end.

get_hashes(Path_arr, L, PowP1_M1, PowP2_M2) ->
    PathLen = array:size(Path_arr),
    if PathLen < L ->
        sets:new();
    true ->
        {H1, H2} = calculate_initial_hash(Path_arr, L, PowP1_M1, PowP2_M2),
        Hashes = sets:add({H1, H2}, sets:new()),

        rolling_hash(Path_arr, L, L, PathLen, H1, H2, PowP1_M1, PowP2_M2, Hashes)
    end.

calculate_initial_hash(Path_arr, L, PowP1_M1, PowP2_M2) ->
    calculate_initial_hash_acc(Path_arr, L - 1, 0, 0, PowP1_M1, PowP2_M2).

calculate_initial_hash_acc(_Path_arr, -1, H1, H2, _PowP1_M1, _PowP2_M2) -> {H1, H2};
calculate_initial_hash_acc(Path_arr, Idx, H1_acc, H2_acc, PowP1_M1, PowP2_M2) ->
    Val = array:get(Idx, Path_arr),
    ValPlus1 = Val + 1,

    P1_pow = array:get(L - 1 - Idx, PowP1_M1), %% P^(L-1-Idx)
    P2_pow = array:get(L - 1 - Idx, PowP2_M2),

    NewH1_acc = (H1_acc + ValPlus1 * P1_pow) rem ?M1,
    NewH2_acc = (H2_acc + ValPlus1 * P2_pow) rem ?M2,

    calculate_initial_hash_acc(Path_arr, Idx - 1, NewH1_acc, NewH2_acc, PowP1_M1, PowP2_M2).

rolling_hash(Path_arr, L, CurrentIdx, PathLen, CurrentH1, CurrentH2, PowP1_M1, PowP2_M2, AccHashes) when CurrentIdx >= PathLen ->
    AccHashes;
rolling_hash(Path_arr, L, CurrentIdx, PathLen, CurrentH1, CurrentH2, PowP1_M1, PowP2_M2, AccHashes) ->
    OldVal = array:get(CurrentIdx - L, Path_arr) + 1,
    NewVal = array:get(CurrentIdx, Path_arr) + 1,

    P1_pow_L_minus_1 = array:get(L - 1, PowP1_M1), %% P1^(L-1) mod M1
    P2_pow_L_minus_1 = array:get(L - 1, PowP2_M2), %% P2^(L-1) mod M2

    %% Calculate new H1
    TermToRemove1 = (OldVal * P1_pow_L_minus_1) rem ?M1,
    H1_temp = (CurrentH1 - TermToRemove1 + ?M1) rem ?M1,
    NextH1 = (H1_temp * ?P1 + NewVal) rem ?M1,

    %% Calculate new H2
    TermToRemove2 = (OldVal * P2_pow_L_minus_1) rem ?M2,
    H2_temp = (CurrentH2 - TermToRemove2 + ?M2) rem ?M2,
    NextH2 = (H2_temp * ?P2 + NewVal) rem ?M2,

    NewAccHashes = sets:add({NextH1, NextH2}, AccHashes),
    rolling_hash(Path_arr, L, CurrentIdx + 1, PathLen, NextH1, NextH2, PowP1_M1, PowP2_M2, NewAccHashes).