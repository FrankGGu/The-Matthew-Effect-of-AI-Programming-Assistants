-module(sol).
-export([amount_of_time/2]).

-record(node, {val, left = none, right = none}).

amount_of_time(Tree, Start) ->
    TreeList = tree_to_list(Tree),
    StartNode = lists:keyfind(Start, 1, TreeList),
    case StartNode of
        false -> 0;
        {_, Left, Right} -> infection_time(Tree, StartNode, 0)
    end.

infection_time(Tree, {Val, Left, Right}, Time) ->
    Time1 = Time + 1,
    InfectionTimes = [Time1 | lists:flatmap(fun(Node) -> infection_time(Tree, Node, Time1) end, [Left, Right])],
    lists:max([Time | InfectionTimes]).

tree_to_list(none) -> [];
tree_to_list(#node{val=Val, left=Left, right=Right}) ->
    [{Val, Left, Right} | tree_to_list(Left) ++ tree_to_list(Right)].