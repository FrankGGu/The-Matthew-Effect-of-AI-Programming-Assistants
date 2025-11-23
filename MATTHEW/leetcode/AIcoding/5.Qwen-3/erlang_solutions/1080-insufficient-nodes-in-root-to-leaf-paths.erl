-module(solution).
-export([remove_leaves/1]).

-record(tree, {val, left, right}).

remove_leaves(undefined) -> undefined;
remove_leaves(#tree{val=Val, left=Left, right=Right}) ->
    Left1 = remove_leaves(Left),
    Right1 = remove_leaves(Right),
    case {Left1, Right1} of
        {undefined, undefined} -> undefined;
        _ -> #tree{val=Val, left=Left1, right=Right1}
    end.