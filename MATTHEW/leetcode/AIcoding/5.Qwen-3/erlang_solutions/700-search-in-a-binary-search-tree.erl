-module(search_in_a_binary_search_tree).
-export([search/2]).

-record(TreeNode, {val, left, right}).

search(_, null) ->
    null;
search(Value, #TreeNode{val = Val, left = Left, right = Right}) ->
    if
        Value == Val ->
            #TreeNode{val = Val, left = Left, right = Right};
        Value < Val ->
            search(Value, Left);
        true ->
            search(Value, Right)
    end.