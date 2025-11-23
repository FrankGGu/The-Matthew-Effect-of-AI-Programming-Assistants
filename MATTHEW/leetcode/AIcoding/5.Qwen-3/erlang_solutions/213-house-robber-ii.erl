-module(house_robber_ii).
-export([rob/1]).

rob([]) -> 0;
rob([H]) -> H;
rob(Houses) ->
    Max = fun(A, B) -> if A > B -> A; true -> B end end,
    Length = length(Houses),
    case Length of
        1 -> hd(Houses);
        _ ->
            First = rob_helper(lists:sublist(Houses, 1, Length - 1)),
            Second = rob_helper(lists:sublist(Houses, 2, Length - 1)),
            Max(First, Second)
    end.

rob_helper([]) -> 0;
rob_helper([H]) -> H;
rob_helper(Houses) ->
    Prev = 0,
    Current = 0,
    lists:foldl(fun(X, {P, C}) -> {C, max(C, P + X)} end, {Prev, Current}, Houses).