-module(solution).
-export([shortest_common_supersequence/2]).

shortest_common_supersequence(S1, S2) ->
    L1 = length(S1),
    L2 = length(S2),
    DP = lists:duplicate(L1 + 1, lists:duplicate(L2 + 1, 0)),
    DP1 = fill_dp(DP, S1, S2, L1, L2),
    build_supersequence(S1, S2, DP1, L1, L2).

fill_dp(DP, _, _, 0, _) -> DP;
fill_dp(DP, _, _, _, 0) -> DP;
fill_dp(DP, S1, S2, I, J) ->
    DP1 = fill_dp(DP, S1, S2, I - 1, J),
    DP2 = fill_dp(DP1, S1, S2, I, J - 1),
    if
        lists:nth(I, S1) =:= lists:nth(J, S2) ->
            lists:replace(I, lists:replace(J, lists:nth(I, DP2), DP2), DP2);
        true ->
            lists:replace(I, lists:max([lists:nth(I - 1, DP1), lists:nth(I, DP2)]), DP2)
    end.

build_supersequence(S1, S2, DP, I, J) ->
    Res = [],
    build_seq(S1, S2, DP, I, J, Res).

build_seq(_, _, DP, 0, 0, Res) -> lists:reverse(Res);
build_seq(S1, S2, DP, I, J, Res) when I > 0, J > 0 ->
    if
        lists:nth(I, S1) =:= lists:nth(J, S2) ->
            build_seq(S1, S2, DP, I - 1, J - 1, [lists:nth(I, S1) | Res]);
        lists:nth(I - 1, DP) > lists:nth(J - 1, DP) ->
            build_seq(S1, S2, DP, I - 1, J, [lists:nth(I, S1) | Res]);
        true ->
            build_seq(S1, S2, DP, I, J - 1, [lists:nth(J, S2) | Res])
    end.