-module(evaluate_division).
-export([calcEquation/3]).

calcEquation(Equations, Values, Queries) ->
  Graph = buildGraph(Equations, Values),
  lists:map(fun(Query) -> solveQuery(Query, Graph, []) end, Queries).

buildGraph(Equations, Values) ->
  buildGraphHelper(Equations, Values, []).

buildGraphHelper([], [], Acc) ->
  Acc;
buildGraphHelper([Equation | RestEquations], [Value | RestValues], Acc) ->
  [Var1, Var2] = Equation,
  Graph1 = updateGraph(Var1, {Var2, Value}, Acc),
  Graph2 = updateGraph(Var2, {Var1, 1.0 / Value}, Graph1),
  buildGraphHelper(RestEquations, RestValues, Graph2).

updateGraph(Var, Edge, Graph) ->
  case lists:keyfind(Var, 1, Graph) of
    false ->
      [{Var, [Edge]} | Graph];
    {Var, Edges} ->
      lists:keyreplace(Var, 1, Graph, {Var, [Edge | Edges]})
  end.

solveQuery([Start, End], Graph, Visited) ->
  solveQueryHelper(Start, End, Graph, Visited, 1.0).

solveQueryHelper(Start, End, Graph, _, Acc) when Start == End ->
  case lists:keyfind(Start, 1, Graph) of
    false -> -1.0;
    _ -> Acc
  end;
solveQueryHelper(Start, End, Graph, Visited, Acc) ->
  case lists:keyfind(Start, 1, Graph) of
    false ->
      -1.0;
    {Start, Edges} ->
      solveQueryHelper2(Edges, Start, End, Graph, Visited, Acc)
  end.

solveQueryHelper2([], _, _, _, _, _) ->
  -1.0;
solveQueryHelper2([{Neighbor, Value} | RestEdges], Start, End, Graph, Visited, Acc) ->
  case lists:member(Neighbor, Visited) of
    true ->
      solveQueryHelper2(RestEdges, Start, End, Graph, Visited, Acc);
    false ->
      Result = solveQueryHelper(Neighbor, End, Graph, [Start | Visited], Acc * Value),
      case Result of
        -1.0 ->
          solveQueryHelper2(RestEdges, Start, End, Graph, Visited, Acc);
        _ ->
          Result
      end
  end.