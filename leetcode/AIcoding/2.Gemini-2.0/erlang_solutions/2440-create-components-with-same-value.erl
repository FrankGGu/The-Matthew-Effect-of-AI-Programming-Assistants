-module(create_components).
-export([max_components/2]).

max_components(Nums, Edges) ->
  N = length(Nums),
  Graph = build_graph(N, Edges),
  sum_nums(Nums, Sum),

  case Sum == 0 of
    true -> N;
    false ->
      max_components_helper(Nums, Graph, Sum, N)
  end.

max_components_helper(Nums, Graph, Sum, N) ->
  lists:foldl(
    fun(TargetSum, Acc) ->
      case Sum rem TargetSum == 0 of
        true ->
          Components = Sum div TargetSum,
          case check_components(Nums, Graph, TargetSum) of
            true -> Components;
            false -> Acc
          end;
        false -> Acc
      end
    end,
    1,
    lists:seq(2, Sum)
  ).

build_graph(N, Edges) ->
  lists:foldl(
    fun([U, V], Acc) ->
      Acc1 = maps:update_with(U, fun(Neighbors) -> [V | Neighbors] end, [V], Acc),
      maps:update_with(V, fun(Neighbors) -> [U | Neighbors] end, [U], Acc1)
    end,
    maps:new(),
    Edges
  ).

sum_nums(Nums, Sum) ->
  lists:foldl(fun(Num, Acc) -> Num + Acc end, 0, Nums).

check_components(Nums, Graph, TargetSum) ->
  N = length(Nums),
  Visited = gb_sets:empty(),
  check_components_helper(Nums, Graph, TargetSum, N, Visited).

check_components_helper(Nums, Graph, TargetSum, N, Visited) ->
  lists:all(
    fun(I) ->
      case gb_sets:is_element(I, Visited) of
        true -> true;
        false ->
          {_, NewVisited} = dfs(I, Nums, Graph, TargetSum, gb_sets:add(I, Visited), 0),
          gb_sets:size(NewVisited) > gb_sets:size(Visited)
      end
    end,
    lists:seq(1, N)
  ).

dfs(Node, Nums, Graph, TargetSum, Visited, CurrentSum) ->
  NewSum = CurrentSum + lists:nth(Node, Nums),
  case NewSum > TargetSum of
    true -> {false, Visited};
    false ->
      case NewSum == TargetSum of
        true -> {true, Visited};
        false ->
          Neighbors = maps:get(Node, Graph, []),
          {Result, NewVisited} = lists:foldl(
            fun(Neighbor, {AccResult, AccVisited}) ->
              case gb_sets:is_element(Neighbor, AccVisited) of
                true -> {AccResult, AccVisited};
                false ->
                  {NeighborResult, NeighborVisited} = dfs(Neighbor, Nums, Graph, TargetSum, gb_sets:add(Neighbor, AccVisited), NewSum),
                  {AccResult and NeighborResult, NeighborVisited}
              end
            end,
            {true, gb_sets:add(Node, Visited)},
            Neighbors
          ),
          {Result, NewVisited}
      end
  end.