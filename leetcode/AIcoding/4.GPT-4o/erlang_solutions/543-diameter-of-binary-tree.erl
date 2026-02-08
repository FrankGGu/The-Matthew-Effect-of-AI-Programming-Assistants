-module(diameter_of_binary_tree).
-export([diameter/1]).

-type tree() :: 'nil' | {Value, tree(), tree()}.

diameter(Tree) ->
    {Diameter, _} = diameter_helper(Tree),
    Diameter.

diameter_helper('nil') ->
    {0, 0};
diameter_helper({_, Left, Right}) ->
    {LDiameter, LHeight} = diameter_helper(Left),
    {RDiameter, RHeight} = diameter_helper(Right),
    Diameter = max(LDiameter, max(RDiameter, LHeight + RHeight)),
    Height = max(LHeight, RHeight) + 1,
    {Diameter, Height}.