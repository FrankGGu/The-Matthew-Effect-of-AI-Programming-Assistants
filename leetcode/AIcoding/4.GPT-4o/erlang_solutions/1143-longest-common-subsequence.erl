-module(solution).
-export([longest_common_subsequence/2]).

longest_common_subsequence(X, Y) ->
    L1 = length(X),
    L2 = length(Y),
    L = lists:duplicate(L1 + 1, lists:duplicate(L2 + 1, 0)),
    L2D = lists:foldl(fun(_, Acc) -> lists:foldl(fun(_, Acc2) -> [0 | Acc2] end, [], Acc) end, L, lists:seq(1, L1)),
    lcs_helper(X, Y, L1, L2, L2D).

lcs_helper(_, _, 0, _, L) -> L;
lcs_helper(_, _, _, 0, L) -> L;
lcs_helper(X, Y, I, J, L) ->
    if
        lists:nth(I, X) == lists:nth(J, Y) ->
            L2 = lists:nth(I, L),
            L2J = lists:nth(J, L2),
            NewL = lists:update_element(J + 1, L2, L2J + 1),
            lcs_helper(X, Y, I - 1, J - 1, lists:update_element(I + 1, L, NewL));
        true ->
            L2 = lists:nth(I, L),
            L2J1 = lists:nth(J + 1, L2),
            L2J2 = lists:nth(J, L2),
            NewL = lists:update_element(J + 1, L2, lists:max(L2J1, L2J2)),
            lcs_helper(X, Y, I, J - 1, lists:update_element(I + 1, L, NewL))
    end.