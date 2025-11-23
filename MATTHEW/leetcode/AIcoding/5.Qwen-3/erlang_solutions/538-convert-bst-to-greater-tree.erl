-module(convert_bst_to_greater_tree).
-export([convert_bst/1]).

-record(tree, {val, left, right}).

convert_bst(nil) ->
    nil;
convert_bst(Tree) ->
    convert_bst(Tree, 0).

convert_bst(nil, _) ->
    nil;
convert_bst(#tree{val=Val, left=Left, right=Right}, Sum) ->
    RightNew = convert_bst(Right, Sum),
    NewSum = Sum + Val,
    LeftNew = convert_bst(Left, NewSum),
    #tree{val=NewSum, left=LeftNew, right=RightNew}.