-module(solution).
-export([distinct_subseq_ii/1]).

distinct_subseq_ii(S) ->
    N = string:length(S),
    Mod = 1000000007,
    Counts = lists:duplicate(26, 0),
    DP = lists:duplicate(N + 1, 0),
    DP[0] = 1,

    lists:foldl(fun(Char, {I, DP}) ->
        Index = $a - Char + 1,
        NewCount = (DP[I] * 2 - counts[Index]) rem Mod,
        Counts1 = lists:mapfun(fun(X) -> X end, Counts),
        Counts1 = lists:sublist(Counts1, 1, Index - 1) ++ [NewCount] ++ lists:sublist(Counts1, Index + 1),
        {I + 1, lists:sublist(DP, 1, I) ++ [NewCount] ++ lists:sublist(DP, I + 2, N)}
    end, {1, DP}, string:to_list(S)),

    (DP[N] - 1) rem Mod.