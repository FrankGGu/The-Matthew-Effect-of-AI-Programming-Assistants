-module(solution).
-export([beautifulIndices/4]).

-include_lib("stdlib/include/array.hrl").

compute_lps(P) ->
    LenP = length(P),
    LPS = array:new([{size, LenP}, {fixed, true}, {default, 0}]),
    compute_lps_loop(P, 1, 0, LPS, LenP).

compute_lps_loop(_P, I, _K, LPS, LenP) when I >= LenP ->
    array:to_list(LPS);
compute_lps_loop(P, I, K, LPS, LenP) ->
    CharI = lists:nth(I+1, P),
    CharK = lists:nth(K+1, P),
    if
        CharI == CharK ->
            NewK = K + 1,
            array:set(I, NewK, LPS),
            compute_lps_loop(P, I + 1, NewK, LPS, LenP);
        K /= 0 ->
            NewK = array:get(K - 1, LPS),
            compute_lps_loop(P, I, NewK, LPS, LenP);
        true -> % K == 0
            array:set(I, 0, LPS),
            compute_lps_loop(P, I + 1, 0, LPS, LenP)
    end.

kmp_search(T, P) ->
    LenP = length(P),
    if LenP == 0 -> []; % Handle empty pattern
       true ->
            LPS = compute_lps(P),
            LenT = length(T),
            kmp_search_loop(T, P, LPS, 0, 0, [], LenT, LenP)
    end.

kmp_search_loop(_T, _P, _LPS, I, _J, Acc, LenT, _LenP) when I >= LenT ->
    lists:reverse(Acc);
kmp_search_loop(T, P, LPS, I, J, Acc, LenT, LenP) ->
    CharT = lists:nth(I+1, T),
    CharP = lists:nth(J+1, P),
    if
        CharT == CharP ->
            NewI = I + 1,
            NewJ = J + 1,
            if
                NewJ == LenP ->
                    NextJ = array:get(J - 1, LPS),
                    kmp_search_loop(T, P, LPS, NewI, NextJ, [I - LenP + 1 | Acc], LenT, LenP);
                true ->
                    kmp_search_loop(T, P, LPS, NewI, NewJ, Acc, LenT, LenP)
            end;
        J /= 0 ->
            NextJ = array:get(J - 1, LPS),
            kmp_search_loop(T, P, LPS, I, NextJ, Acc, LenT, LenP);
        true -> % J == 0
            NewI = I + 1,
            kmp_search_loop(T, P, LPS, NewI, J, Acc, LenT, LenP)
    end.

beautifulIndices(S, A, B, K) ->
    A_indices = kmp_search(S, A),
    B_indices = kmp_search(S, B),

    if B_indices == [] ->
        [];
    true ->
        find_beautiful_two_pointers_list_tail(A_indices, B_indices, K, [])
    end.

find_beautiful_two_pointers_list_tail([], _B_current_list, _K, Acc) ->
    lists:reverse(Acc);
find_beautiful_two_pointers_list_tail([I_a | RestA], B_current_list, K, Acc) ->
    {New_B_current_list, Found} = check_and_advance_b(I_a, B_current_list, K),

    if Found ->
        find_beautiful_two_pointers_list_tail(RestA, New_B_current_list, K, [I_a | Acc]);
    true ->
        find_beautiful_two_pointers_list_tail(RestA, New_B_current_list, K, Acc)
    end.

check_and_advance_b(I_a, B_list, K) ->
    MinJ = I_a - K,
    MaxJ = I_a + K,

    B_list_after_min = skip_until_ge(B_list, MinJ),

    if B_list_after_min == [] ->
        {B_list_after_min, false};
    true ->
        HeadB = hd(B_list_after_min),
        if HeadB <= MaxJ ->
            {B_list_after_min, true};
        true ->
            {B_list_after_min, false}
        end
    end.

skip_until_ge([], _Value) -> [];
skip_until_ge([H | T], Value) ->
    if H >= Value ->
        [H | T];
    true ->
        skip_until_ge(T, Value)
    end.