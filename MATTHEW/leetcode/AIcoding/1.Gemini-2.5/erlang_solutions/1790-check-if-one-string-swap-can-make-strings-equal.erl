-module(solution).
-export([are_almost_equal/2]).

-spec are_almost_equal(S1 :: unicode:unicode_binary(), S2 :: unicode:unicode_binary()) -> boolean().
are_almost_equal(S1_bin, S2_bin) ->
    S1 = unicode:characters_to_list(S1_bin),
    S2 = unicode:characters_to_list(S2_bin),
    check_swap(S1, S2, [], []).

check_swap([], [], [], []) ->
    true;
check_swap([], [], [C1_s1, C2_s1], [C1_s2, C2_s2]) ->
    C1_s1 == C2_s2 andalso C2_s1 == C1_s2;
check_swap([], [], _, _) ->
    false;
check_swap([H1|T1], [H2|T2], DiffS1, DiffS2) ->
    if H1 == H2 ->
        check_swap(T1, T2, DiffS1, DiffS2);
    true -> % H1 /= H2
        NewDiffS1 = [H1|DiffS1],
        NewDiffS2 = [H2|DiffS2],
        if length(NewDiffS1) > 2 ->
            false;
        true ->
            check_swap(T1, T2, NewDiffS1, NewDiffS2)
        end
    end.