-module(solution).
-export([flip_match_preorder/2]).

-record(node, {val, left = null, right = null}).

flip_match_preorder(Preorder, Root) ->
    flip_match_preorder_helper(Preorder, Root, #node{}).

flip_match_preorder_helper([], _, _) -> [];
flip_match_preorder_helper([H | T], Node, Visited) ->
    case Node of
        null -> [];
        #node{val = H, left = Left, right = Right} ->
            Visited1 = #node{Visited | val = H},
            [H | flip_match_preorder_helper(T, Left, Visited1)] ++ 
            flip_match_preorder_helper(T, Right, Visited1)
    end.