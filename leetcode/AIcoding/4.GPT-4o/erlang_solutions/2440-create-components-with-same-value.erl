-module(solution).
-export([component_value/2]).

-type tree() :: 
    none
  | {Node, List(tree())}.

component_value(Tree, Target) ->
    {Value, Count} = total_value(Tree),
    if
        Value rem Target /= 0 ->
            0;
        true ->
            component_count(Tree, Target, Value div Target)
    end.

total_value(none) ->
    {0, 0};
total_value({Node, Children}) ->
    {Node + lists:sum([total_value(Child) || Child <- Children]), 1 + lists:sum([element(2, total_value(Child)) || Child <- Children])}.

component_count(none, _, _) ->
    0;
component_count({Node, Children}, Target, Value) ->
    SubValue = Node,
    NewCount = if SubValue == Value -> 1; true -> 0 end,
    NewCount + lists:sum([component_count(Child, Target, Value) || Child <- Children]).