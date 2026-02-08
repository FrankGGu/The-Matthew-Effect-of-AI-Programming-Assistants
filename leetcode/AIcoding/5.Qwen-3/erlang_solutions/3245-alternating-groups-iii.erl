-module(alternating_groups_iii).
-export([numberOfAlternatingGroups/1]).

numberOfAlternatingGroups(S) ->
    N = length(S),
    Count = 0,
    lists:foldl(fun(I, Acc) -> 
        A = if I > 0 -> lists:nth(I, S); true -> $0 end,
        B = if I+1 < N -> lists:nth(I+1, S); true -> $0 end,
        C = if I+2 < N -> lists:nth(I+2, S); true -> $0 end,
        if (A /= B) and (B /= C) -> Acc + 1; true -> Acc end
    end, Count, lists:seq(0, N-1)).