-module(solution).
-export([increasingBST/1]).

-record(tree, {val, left = none, right = none}).

increasingBST(Root) ->
    {NewRoot, _} = increasingBSTHelper(Root, none),
    NewRoot.

increasingBSTHelper(none, Prev) ->
    {Prev, Prev};
increasingBSTHelper(#tree{val=Val, left=Left, right=Right}, Prev) ->
    {NewRoot, Last} = increasingBSTHelper(Left, Prev),
    NewNode = #tree{val=Val, left=none, right=none},
    case Last of
        none -> {NewNode, NewNode};
        _ -> Last#tree{right=NewNode},
             {NewRoot, NewNode}
    end,
    increasingBSTHelper(Right, NewNode).