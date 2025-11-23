-module(solution).
-export([longest_common_suffix_queries/2]).

longest_common_suffix_queries/2 ->
    {N, Q} = lists:map(fun(X) -> {hd(X), tl(X)} end, [N, Q]),
    Suffixes = lists:map(fun(S) -> suffix(S) end, lists:nth(1, lists:seq(1, N))),
    Results = lists:map(fun({i, j}) -> longest_suffix(Suffixes, i, j) end, lists:nth(2, lists:seq(1, Q))),
    Results.

suffix(S) ->
    lists:reverse(lists:map(fun(X) -> lists:reverse(X) end, string:tokens(S, ""))).

longest_suffix(Suffixes, I, J) ->
    SuffixI = lists:nth(I, Suffixes),
    SuffixJ = lists:nth(J, Suffixes),
    longest_common_suffix(SuffixI, SuffixJ).

longest_common_suffix([], _) -> "";
longest_common_suffix(_, []) -> "";
longest_common_suffix([H1 | T1], [H2 | T2]) when H1 =:= H2 ->
    [H1 | longest_common_suffix(T1, T2)];
longest_common_suffix(_, _) -> [].