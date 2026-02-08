-module(trim_binary_search_tree).
-export([trim_bst/2]).

-record(tree, {val, left, right}).

trim_bst(_, nil) ->
    nil;
trim_bst(Bound, #tree{val=Val, left=Left, right=Right}) when Val < Bound ->
    trim_bst(Bound, Right);
trim_bst(Bound, #tree{val=Val, left=Left, right=Right}) when Val > Bound ->
    trim_bst(Bound, Left);
trim_bst(_, #tree{val=Val, left=Left, right=Right}) ->
    #tree{val=Val, left=trim_bst(Bound, Left), right=trim_bst(Bound, Right)}.