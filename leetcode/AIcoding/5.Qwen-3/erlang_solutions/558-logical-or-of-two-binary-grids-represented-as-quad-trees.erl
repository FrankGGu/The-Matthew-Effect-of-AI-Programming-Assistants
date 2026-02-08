-module(logical_or_of_two_binary_grids_represented_as_quad_trees).
-export([intersect/2]).

-include("leetcode.hrl").

intersect(Node1, Node2) ->
    case {Node1#quad_tree.is_leaf, Node2#quad_tree.is_leaf} of
        {true, true} ->
            #quad_tree{val = Node1#quad_tree.val or Node2#quad_tree.val, is_leaf = true, children = []};
        {true, false} ->
            case Node1#quad_tree.val of
                true -> Node1;
                false -> Node2
            end;
        {false, true} ->
            case Node2#quad_tree.val of
                true -> Node2;
                false -> Node1
            end;
        {false, false} ->
            Children1 = Node1#quad_tree.children,
            Children2 = Node2#quad_tree.children,
            NewChildren = lists:zipwith(fun intersect/2, Children1, Children2),
            HasTrue = lists:any(fun(#quad_tree{val = Val}) -> Val end, NewChildren),
            if
                HasTrue ->
                    #quad_tree{val = true, is_leaf = true, children = []};
                true ->
                    #quad_tree{val = false, is_leaf = false, children = NewChildren}
            end
    end.