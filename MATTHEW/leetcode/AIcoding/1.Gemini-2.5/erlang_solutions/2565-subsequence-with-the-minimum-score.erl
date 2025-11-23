-module(solution).
-export([min_score/2]).

min_score(S, Target) ->
    N = length(S),
    M = length(Target),

    S_bin = list_to_binary(S),
    Target_bin = list_to_binary(Target),

    P = calculate_P_array(S_bin, Target_bin, N, M),
    R = calculate_R_array(S_bin, Target_bin, N, M),

    MinScore = N,

    Score1 = max(array:get(0, P), N - 1 - array:get(M - 1, P)),
    Score2 = max(array:get(0, R), N - 1 - array:get(M - 1, R)),

    CurrentMinScore = min(Score1, Score2),

    FinalMinScore = lists:foldl(fun(K, AccMinScore) ->
        Pk = array:get(K, P),
        Rk_plus_1 = array:get(K + 1, R),
        if
            Pk < Rk_plus_1 ->
                I0 = array:get(0, P),
                Im_minus_1 = array:get(M - 1, R),
                Score = max(I0, N - 1 - Im_minus_1),
                min(AccMinScore, Score);
            true ->
                AccMinScore
        end
    end, CurrentMinScore, lists:seq(0, M - 2)),

    FinalMinScore.

calculate_P_array(S_bin, Target_bin, N, M) ->
    P_arr = array:new({size, M}),
    calculate_P_array_loop(S_bin, Target_bin, N, M, 0, 0, P_arr).

calculate_P_array_loop(S_bin, Target_bin, N, M, T_idx, S_search_start_idx, P_arr) when T_idx < M ->
    TargetChar = binary:at(Target_bin, T_idx),
    FoundSIdx = find_char_from_left(S_bin, TargetChar, N, S_search_start_idx),
    NewP_arr = array:set(T_idx, FoundSIdx, P_arr),
    calculate_P_array_loop(S_bin, Target_bin, N, M, T_idx + 1, FoundSIdx + 1, NewP_arr);
calculate_P_array_loop(_S_bin, _Target_bin, _N, _M, _T_idx, _S_search_start_idx, P_arr) ->
    P_arr.

find_char_from_left(S_bin, Char, N, CurrentS_idx) when CurrentS_idx < N ->
    if binary:at(S_bin, CurrentS_idx) == Char ->
        CurrentS_idx;
    true ->
        find_char_from_left(S_bin, Char, N, CurrentS_idx + 1)
    end;
find_char_from_left(_S_bin, _Char, _N, _CurrentS_idx) ->
    throw(not_found).

calculate_R_array(S_bin, Target_bin, N, M) ->
    R_arr = array:new({size, M}),
    calculate_R_array_loop(S_bin, Target_bin, N, M, M - 1, N - 1, R_arr).

calculate_R_array_loop(S_bin, Target_bin, N, M, T_idx, S_search_start_idx, R_arr) when T_idx >= 0 ->
    TargetChar = binary:at(Target_bin, T_idx),
    FoundSIdx = find_char_from_right(S_bin, TargetChar, N, S_search_start_idx),
    NewR_arr = array:set(T_idx, FoundSIdx, R_arr),
    calculate_R_array_loop(S_bin, Target_bin, N, M, T_idx - 1, FoundSIdx - 1, NewR_arr);
calculate_R_array_loop(_S_bin, _Target_bin, _N, _M, _T_idx, _S_search_start_idx, R_arr) ->
    R_arr.

find_char_from_right(S_bin, Char, _N, CurrentS_idx) when CurrentS_idx >= 0 ->
    if binary:at(S_bin, CurrentS_idx) == Char ->
        CurrentS_idx;
    true ->
        find_char_from_right(S_bin, Char, _N, CurrentS_idx - 1)
    end;
find_char_from_right(_S_bin, _Char, _N, _CurrentS_idx) ->
    throw(not_found).

max(A, B) when A >= B -> A;
max(A, B) -> B.

min(A, B) when A =< B -> A;
min(A, B) -> B.