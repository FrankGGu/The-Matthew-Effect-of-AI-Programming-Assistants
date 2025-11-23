-module(maximum_sum).
-export([maximum_sum/1]).

maximum_sum(Nodes) ->
  maximum_sum_helper(Nodes, []).

maximum_sum_helper([], Acc) ->
  lists:max([0 | Acc]);
maximum_sum_helper([Node | Rest], Acc) ->
  Value = maps:get(value, Node),
  Children = maps:get(children, Node, []),
  With = Value + lists:sum([without_child(C) || C <- Children]),
  Without = lists:sum([maximum_sum_helper([C], []) || C <- Children]),
  maximum_sum_helper(Rest, [With, Without | Acc]).

without_child(Node) ->
  Children = maps:get(children, Node, []),
  lists:sum([maximum_sum_helper([C], []) || C <- Children]).