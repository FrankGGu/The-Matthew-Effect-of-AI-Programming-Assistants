-module(solution).
-export([smallest_from_leaf/1]).

-record(node, {val, left=nil, right=nil}).

smallest_from_leaf(Tree) ->
    Lists = smallest_from_leaf(Tree, []),
    lists:foldl(fun(S1, S2) -> min_string(S1, S2) end, [], Lists).

smallest_from_leaf(nil, Acc) -> [Acc];
smallest_from_leaf(#node{val=Val, left=Left, right=Right}, Acc) ->
    Char = lists:nth(1, Val),
    NewAcc = [Char | Acc],
    case {Left, Right} of
        {nil, nil} -> [NewAcc];
        {Left, nil} -> smallest_from_leaf(Left, NewAcc);
        {nil, Right} -> smallest_from_leaf(Right, NewAcc);
        {Left, Right} ->
            lists:append(smallest_from_leaf(Left, NewAcc), smallest_from_leaf(Right, NewAcc))
    end.

min_string([], S) -> S;
min_string(S, []) -> S;
min_string([H1 | T1], [H2 | T2]) ->
    case H1 < H2 of
        true -> [H1 | T1];
        false -> [H2 | T2]
    end.