-module(binary_tree_paths).
-export([binary_tree_paths/1]).

-record(tree, {val, left, right}).

binary_tree_paths(nil) -> [];
binary_tree_paths(#tree{val=Val, left=Left, right=Right}) ->
    case {Left, Right} of
        {nil, nil} -> [integer_to_list(Val)];
        _ ->
            lists:flatmap(fun(Path) -> [integer_to_list(Val) ++ "->" ++ Path] end,
                          binary_tree_paths(Left) ++ binary_tree_paths(Right))
    end.