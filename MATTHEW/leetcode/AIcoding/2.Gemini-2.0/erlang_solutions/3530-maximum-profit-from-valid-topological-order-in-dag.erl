-module(maximum_profit_valid_topological_order).
-export([solve/2]).

solve(Profits, Edges) ->
  N = length(Profits),
  {Graph, Indegrees} = build_graph(Edges, N),
  topological_sort(Graph, Indegrees, Profits, N).

build_graph(Edges, N) ->
  Graph = lists:foldl(fun({U, V}, Acc) ->
    maps:update_with(U, fun(List) -> [V | List] end, [V], Acc)
  end, #{}, Edges),
  Indegrees = lists:foldl(fun({U, V}, Acc) ->
    maps:update_with(V, fun(Count) -> Count + 1 end, 1, Acc)
  end, #{}, Edges),
  {Graph, Indegrees}.

topological_sort(Graph, Indegrees, Profits, N) ->
  Queue = lists:filter(fun(I) -> not maps:is_key(I, Indegrees) end, lists:seq(1, N)),
  DP = lists:foldl(fun(I, Acc) -> maps:put(I, Profits !! (I - 1), Acc) end, #{}, lists:seq(1, N)),
  topological_sort_helper(Graph, Indegrees, Profits, N, Queue, DP, 0).

topological_sort_helper(_Graph, _Indegrees, _Profits, 0, [], DP, Acc) ->
  Acc;
topological_sort_helper(Graph, Indegrees, Profits, N, [Node | Rest], DP, Acc) ->
  NewAcc = max(Acc, maps:get(Node, DP)),
  NewIndegrees = case maps:is_key(Node, Graph) of
    true ->
      lists:foldl(fun(Neighbor, Acc1) ->
        UpdatedIndegree = maps:update_with(Neighbor, fun(Count) -> Count - 1 end, 0, Acc1),
        DP2 = max(maps:get(Neighbor, DP, 0), maps:get(Node, DP) + (Profits !! (Neighbor - 1))),
        maps:put(Neighbor, DP2, DP)
      end, Indegrees, maps:get(Node, Graph));
    false ->
      Indegrees
  end,
  NewQueue = lists:foldl(fun(I, Acc1) ->
    case maps:is_key(I, NewIndegrees) of
      true ->
        case maps:get(I, NewIndegrees) == 0 of
          true ->
            [I | Acc1];
          false ->
            Acc1
        end;
      false ->
        [I | Acc1]
    end
  end, Rest, lists:seq(1, length(Profits))),
  topological_sort_helper(Graph, NewIndegrees, Profits, N - 1, NewQueue, DP, NewAcc).