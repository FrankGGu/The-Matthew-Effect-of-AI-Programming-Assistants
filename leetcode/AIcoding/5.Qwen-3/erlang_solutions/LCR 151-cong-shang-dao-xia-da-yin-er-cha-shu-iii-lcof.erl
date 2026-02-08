-module(solution).
-export([level_order/1]).

level_order(Nums) ->
    case Nums of
        [] -> [];
        _ ->
            Tree = build_tree(Nums, 0),
            traverse_tree(Tree, 1)
    end.

build_tree([], _) -> [];
build_tree([H|T], Index) ->
    Node = {H, [], []},
    LeftIndex = 2 * Index + 1,
    RightIndex = 2 * Index + 2,
    Left = if LeftIndex < length(T) -> build_tree(T, LeftIndex); true -> [] end,
    Right = if RightIndex < length(T) -> build_tree(T, RightIndex); true -> [] end,
    [Node | Left ++ Right].

traverse_tree([], _) -> [];
traverse_tree([H|T], Level) ->
    Value = element(1, H),
    Left = element(2, H),
    Right = element(3, H),
    Result = [Value | traverse_tree(Left ++ Right, Level + 1)],
    Result ++ traverse_tree(T, Level).