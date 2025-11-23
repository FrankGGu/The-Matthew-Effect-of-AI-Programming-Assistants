-module(solution).
-export([intersect/2]).

-record(node, {val, isLeaf = false, topLeft = null, topRight = null, bottomLeft = null, bottomRight = null}).

intersect(Tree1, Tree2) ->
    case {Tree1, Tree2} of
        {{Val1, true, _, _, _, _}, {Val2, true, _, _, _, _}} ->
            #node{val = Val1 orel Val2, isLeaf = true};
        {{Val1, true, _, _, _, _}, _} ->
            Tree1;
        {_, {Val2, true, _, _, _, _}} ->
            Tree2;
        _ ->
            #node{
                val = false,
                isLeaf = false,
                topLeft = intersect(Tree1#node.topLeft, Tree2#node.topLeft),
                topRight = intersect(Tree1#node.topRight, Tree2#node.topRight),
                bottomLeft = intersect(Tree1#node.bottomLeft, Tree2#node.bottomLeft),
                bottomRight = intersect(Tree1#node.bottomRight, Tree2#node.bottomRight)
            }
    end.