-module(solution).
-export([longest_happy_prefix/1]).

longest_happy_prefix(S) ->
    N = length(S),
    KMP(S, N).

KMP(S, N) ->
    LPS = lps(S, N, [0]),
    lists:nth(N, LPS).

lps(_, 0, L) -> L;
lps(S, N, L) ->
    Prev = lists:nth(N-1, L),
    if
        Prev =:= 0 ->
            lps_helper(S, N, L, 0, 1);
        true ->
            lps_helper(S, N, L, Prev, 1)
    end.

lps_helper(S, N, L, Len, I) when I < N ->
    if
        lists:nth(I, S) =:= lists:nth(Len, S) ->
            lps_helper(S, N, lists.append(L, [Len + 1]), Len + 1, I + 1);
        Len > 0 ->
            lps_helper(S, N, L, lists:nth(Len - 1, L), I);
        true ->
            lps_helper(S, N, lists.append(L, [0]), 0, I + 1)
    end;
lps_helper(_, _, L, _, _) -> L.