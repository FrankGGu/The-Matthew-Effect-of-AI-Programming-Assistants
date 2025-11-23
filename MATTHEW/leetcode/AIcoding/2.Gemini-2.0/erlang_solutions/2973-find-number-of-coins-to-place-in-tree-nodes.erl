-module(find_number_of_coins).
-export([maximum_weighted_sum/3]).

maximum_weighted_sum(Edges, Cost, N) ->
  Graph = build_graph(Edges, N),
  {_, Result} = dfs(0, -1, Graph, Cost),
  Result.

build_graph(Edges, N) ->
  build_graph(Edges, N, lists:seq(0, N - 1), []).

build_graph([], _, Nodes, Acc) ->
  lists:foldl(fun(Node, G) -> maps:put(Node, [], G) end, maps:from_list(Acc), Nodes);
build_graph([{U, V} | Rest], N, Nodes, Acc) ->
  Graph1 = lists:keyfind(U, 1, Acc),
  Graph2 = lists:keyfind(V, 1, Acc),
  NewAcc =
    case {Graph1, Graph2} of
      {false, false} ->
        [{U, [V]}, {V, [U]} | Acc];
      {false, true} ->
        [{U, [V]} | lists:keyreplace(V, 1, Acc, {V, [U | maps:get(V, maps:from_list(Acc))]})];
      {true, false} ->
        [{V, [U]} | lists:keyreplace(U, 1, Acc, {U, [V | maps:get(U, maps:from_list(Acc))]})];
      {true, true} ->
        lists:keyreplace(
          U,
          1,
          lists:keyreplace(V, 1, Acc, {V, [U | maps:get(V, maps:from_list(Acc))]}),
          {U, [V | maps:get(U, maps:from_list(Acc))]}
        )
    end,
  build_graph(Rest, N, Nodes, NewAcc).

dfs(Node, Parent, Graph, Cost) ->
  Children = lists:filter(fun(Child) -> Child /= Parent end, maps:get(Node, Graph)),
  ChildResults = [dfs(Child, Node, Graph, Cost) || Child <- Children],
  Sum = lists:sum([Second || {_, Second} <- ChildResults]),
  SortedCosts = lists:sort(lists:reverse([First || {First, _} <- ChildResults])),
  Take = min(length(SortedCosts), length(Cost) - 1),
  SelectedCost = lists:sublist(SortedCosts, 1, Take),
  NodeCost = lists:sum(SelectedCost) + Cost[Node + 1],
  {NodeCost, Sum + NodeCost}.