-module(build_matrix).
-export([buildMatrix/3]).

buildMatrix(K, RowConditions, ColConditions) ->
  RowGraph = lists:foldl(fun([A, B], Acc) -> add_edge(A, B, Acc) end, [], RowConditions),
  ColGraph = lists:foldl(fun([A, B], Acc) -> add_edge(A, B, Acc) end, [], ColConditions),

  RowTopoSort = topological_sort(K, RowGraph),
  ColTopoSort = topological_sort(K, ColGraph),

  case {RowTopoSort, ColTopoSort} of
    {error, _} -> [];
    {_, error} -> [];
    {Rows, Cols} ->
      Indices = lists:zip(Cols, lists:seq(1, length(Cols))),
      Result = lists:map(fun(_) -> lists:duplicate(K, 0) end, lists:seq(1, K)),
      FilledResult = lists:foldl(
        fun(Row, Acc) ->
          ColIndex = proplists:get_value(Row, Indices),
          RowIndex = lists:index(Row, Rows),
          update_matrix(Acc, RowIndex, ColIndex, Row)
        end,
        Result,
        Rows
      ),
      FilledResult
  end.

add_edge(A, B, Graph) ->
  case lists:keyfind(A, 1, Graph) of
    false ->
      [{A, [B]} | Graph];
    {A, Neighbors} ->
      lists:keyreplace(A, 1, Graph, {A, [B | Neighbors]})
  end.

topological_sort(K, Graph) ->
  InDegree = calculate_in_degree(K, Graph),
  Queue = [Node || {Node, Degree} <- InDegree, Degree == 0],
  topo_sort_helper(K, Graph, InDegree, Queue, []).

topo_sort_helper(K, _Graph, _InDegree, [], Acc) when length(Acc) == K ->
  lists:reverse(Acc);
topo_sort_helper(K, Graph, InDegree, [], _Acc) ->
  error;
topo_sort_helper(K, Graph, InDegree, [Node | Rest], Acc) ->
  NewAcc = [Node | Acc],
  Neighbors = proplists:get_value(Node, Graph, []),
  UpdatedInDegree = lists:foldl(
    fun(Neighbor, CurrentInDegree) ->
      lists:keyreplace(Neighbor, 1, CurrentInDegree, {Neighbor, proplists:get_value(Neighbor, CurrentInDegree) - 1})
    end,
    InDegree,
    Neighbors
  ),
  NewQueue = lists:foldl(
    fun({Neighbor, Degree}, QueueAcc) ->
      case lists:member(Neighbor, QueueAcc) of
        true -> QueueAcc;
        false when Degree == 0 -> [Neighbor | QueueAcc];
        _ -> QueueAcc
      end
    end,
    Rest,
    UpdatedInDegree
  ),
  topo_sort_helper(K, Graph, UpdatedInDegree, NewQueue, NewAcc).

calculate_in_degree(K, Graph) ->
  Nodes = lists:seq(1, K),
  lists:map(
    fun(Node) ->
      Degree = lists:foldl(
        fun({_, Neighbors}, Acc) ->
          case lists:member(Node, Neighbors) of
            true -> Acc + 1;
            _ -> Acc
          end
        end,
        0,
        Graph
      ),
      {Node, Degree}
    end,
    Nodes
  ).

update_matrix(Matrix, RowIndex, ColIndex, Value) ->
  lists:nth(RowIndex, lists:map(fun(Row, I) -> if I == RowIndex then lists:nth(ColIndex, lists:map(fun(Val, J) -> if J == ColIndex then Value else Val end, Row, lists:seq(1, length(Row))))) else Row end, Matrix, lists:seq(1, length(Matrix)))) .