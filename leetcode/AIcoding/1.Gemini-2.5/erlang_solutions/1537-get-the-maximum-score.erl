-module(solution).
-export([get_max_score/2]).

get_max_score(Nums1, Nums2) ->
    Mod = 1000000007,
    solve(Nums1, Nums2, 0, 0, 0, Mod).

solve([], [], S1, S2, AccScore, Mod) ->
    (AccScore + max(S1, S2)) rem Mod;

solve(L1, [], S1, S2, AccScore, Mod) ->
    RemainingSum1 = lists:foldl(fun(X, Acc) -> (Acc + X) rem Mod end, S1, L1),
    (AccScore + max(RemainingSum1, S2)) rem Mod;

solve([], L2, S1, S2, AccScore, Mod) ->
    RemainingSum2 = lists:foldl(fun(X, Acc) -> (Acc + X) rem Mod end, S2, L2),
    (AccScore + max(S1, RemainingSum2)) rem Mod;

solve([H1|T1], [H2|T2], S1, S2, AccScore, Mod) when H1 < H2 ->
    solve(T1, [H2|T2], (S1 + H1) rem Mod, S2, AccScore, Mod);

solve([H1|T1], [H2|T2], S1, S2, AccScore, Mod) when H1 > H2 ->
    solve([H1|T1], T2, S1, (S2 + H2) rem Mod, AccScore, Mod);

solve([H|T1], [H|T2], S1, S2, AccScore, Mod) -> % H1 == H2, use H for common element
    NewAccScore = (AccScore + max(S1, S2) + H) rem Mod,
    solve(T1, T2, 0, 0, NewAccScore, Mod).