-module(solution).
-export([take_k_of_each_character_from_left_and_right/2]).

take_k_of_each_character_from_left_and_right(S, K) ->
    N = length(S),

    InitialCounts = #{'a' => 0, 'b' => 0, 'c' => 0},
    TotalCounts = lists:foldl(fun(Char, Acc) ->
                                  maps:update_with(Char, fun(C) -> C + 1 end, 1, Acc)
                              end, InitialCounts, S),

    TotalA = maps:get('a', TotalCounts),
    TotalB = maps:get('b', TotalCounts),
    TotalC = maps:get('c', TotalCounts),

    TargetA = TotalA - K,
    TargetB = TotalB - K,
    TargetC = TotalC - K,

    S_array = array:from_list(S),

    MaxRemovedLen = slide(0, 0, InitialCounts, 0, S_array, N, TargetA, TargetB, TargetC),

    N - MaxRemovedLen.

slide(R_idx, L_idx, CurrentCounts, MaxLen, S_array, N, TargetA, TargetB, TargetC) when R_idx < N ->
    CharR = array:get(R_idx, S_array),

    NewCurrentCounts = maps:update_with(CharR, fun(C) -> C + 1 end, 1, CurrentCounts),

    {UpdatedL_idx, ValidWindowCounts} =
        check_and_shrink(L_idx, R_idx, S_array, NewCurrentCounts, TargetA, TargetB, TargetC),

    CurrentWindowLen = R_idx - UpdatedL_idx + 1,
    NewMaxLen = max(MaxLen, CurrentWindowLen),

    slide(R_idx + 1, UpdatedL_idx, ValidWindowCounts, NewMaxLen, S_array, N, TargetA, TargetB, TargetC);

slide(_R_idx, _L_idx, _CurrentCounts, MaxLen, _S_array, _N, _TargetA, _TargetB, _TargetC) ->
    MaxLen.

check_and_shrink(L_idx, R_idx, S_array, CurrentCounts, TargetA, TargetB, TargetC) ->
    A_count = maps:get('a', CurrentCounts),
    B_count = maps:get('b', CurrentCounts),
    C_count = maps:get('c', CurrentCounts),

    case (A_count =< TargetA) and (B_count =< TargetB) and (C_count =< TargetC) of
        true ->
            {L_idx, CurrentCounts};
        false ->
            if L_idx > R_idx ->
                {L_idx, CurrentCounts};
            true ->
                CharL = array:get(L_idx, S_array),
                ShrunkCounts = maps:update_with(CharL, fun(C) -> C - 1 end, 0, CurrentCounts),
                check_and_shrink(L_idx + 1, R_idx, S_array, ShrunkCounts, TargetA, TargetB, TargetC)
            end
    end.