-module(solution).
-export([minimum_operations/1]).

-record(node, {val, left = none, right = none}).

minimum_operations(Root) ->
    Levels = level_order(Root, []),
    lists:foldl(fun (Level, Acc) -> Acc + min_operations(Level) end, 0, Levels).

level_order(none, Acc) -> Acc;
level_order(Root, Acc) ->
    NewAcc = case Acc of
        [] -> [[Root#node.val]];
        _ -> [lists:append([Root#node.val], lists:nth(length(Acc), Acc))]
    end,
    level_order(Root#node.left, NewAcc),
    level_order(Root#node.right, NewAcc).

min_operations(Level) ->
    Sorted = lists:sort(Level),
    lists:foldl(fun (X, Acc) -> Acc + (lists:position(X, Sorted) - lists:position(X, Level)) end, 0, Level).