-module(solution).

-export([find_minimum_diameter/2]).

-record(tree, {left, right}).

find_minimum_diameter(Tree1, Tree2) ->
    MergedTree = merge_trees(Tree1, Tree2),
    min_diameter(MergedTree).

merge_trees(undefined, T) -> T;
merge_trees(T, undefined) -> T;
merge_trees(Tree1, Tree2) ->
    #tree{left = merge_trees(Tree1#tree.left, Tree2#tree.left),
          right = merge_trees(Tree1#tree.right, Tree2#tree.right)}.

min_diameter(Tree) ->
    case Tree of
        undefined -> 0;
        _ -> calculate_diameter(Tree) 
    end.

calculate_diameter(Tree) ->
    {Diameter, _} = calculate(Tree),
    Diameter.

calculate(Tree) ->
    case Tree of
        undefined -> {0, 0};
        _ ->
            {LeftDiameter, LeftHeight} = calculate(Tree#tree.left),
            {RightDiameter, RightHeight} = calculate(Tree#tree.right),
            Height = max(LeftHeight, RightHeight) + 1,
            Diameter = max(LeftDiameter, RightDiameter),
            Diameter = max(Diameter, LeftHeight + RightHeight),
            {Diameter, Height}
    end.