-module(tree_of_coprimes).
-export([coprimes/2]).

coprimes(Edges, N) ->
  Graph = lists:foldl(fun([U, V], Acc) ->
                        Acc#{U => lists:append(maps:get(U, Acc, []), [V]),
                              V => lists:append(maps:get(V, Acc, []), [U])}
                      end, #{}, Edges),
  coprimes_helper(Graph, N).

coprimes_helper(Graph, N) ->
  Values = lists:seq(1, N),
  coprimes_helper(Graph, Values).

coprimes_helper(Graph, Values) ->
  coprimes_helper(Graph, Values, lists:seq(1, length(Values))).

coprimes_helper(Graph, Values, Nodes) ->
  coprimes_helper(Graph, Values, Nodes, lists:repeat(length(Values), -1)).

coprimes_helper(Graph, Values, [Node | Rest], Acc) ->
  coprimes_helper(Graph, Values, Rest, coprimes_helper1(Graph, Values, Node, Acc, [], 0, Node, [])).
coprimes_helper(Graph, Values, [], Acc) ->
  Acc.

coprimes_helper1(Graph, Values, Node, Acc, Visited, Depth, StartNode, Path) ->
  MaybeCoprime = find_coprime(Values, Node, Path, Values),
  case MaybeCoprime of
    none ->
      Acc;
    {CoprimeNode, CoprimeValue, CoprimeDepth} ->
      lists:nth(Node, lists:seq(1, length(Values))) == Node andalso
        lists:nth(CoprimeNode, lists:seq(1, length(Values))) == CoprimeNode,
      lists:nth(Node, lists:seq(1, length(Values))) == Node andalso
        lists:nth(CoprimeNode, lists:seq(1, length(Values))) == CoprimeNode,
      lists:nth(Node, lists:seq(1, length(Values))) == Node andalso
        lists:nth(CoprimeNode, lists:seq(1, length(Values))) == CoprimeNode,

      lists:nth(Node, lists:seq(1, length(Values))) == Node andalso
        lists:nth(CoprimeNode, lists:seq(1, length(Values))) == CoprimeNode,

      Acc#{Node => CoprimeNode}
  end.

find_coprime(Values, Node, Path, AllValues) ->
  Value = lists:nth(Node, Values),
  find_coprime1(Node, Value, Path, AllValues, [], 0).

find_coprime1(Node, Value, Path, AllValues, BestSoFar, BestDepth) ->
  find_coprime1_helper(AllValues, Value, Path, BestSoFar, BestDepth, length(AllValues), 0).

find_coprime1_helper([], _, _, BestSoFar, _, _, _) ->
  case BestSoFar of
    [] -> none;
    [BestNode | _] -> {BestNode, lists:nth(BestNode, AllValues), BestDepth}
  end;
find_coprime1_helper([H | T], Value, Path, BestSoFar, BestDepth, Index, Depth) ->
  case lists:member(H, Path) of
    true -> find_coprime1_helper(T, Value, Path, BestSoFar, BestDepth, Index, Depth+1);
    false ->
      case gcd(Value, H) == 1 of
        true ->
          case BestSoFar of
            [] -> find_coprime1_helper(T, Value, Path, [H], Depth, Index, Depth+1);
            _ ->
              case Depth < BestDepth of
                true -> find_coprime1_helper(T, Value, Path, [H], Depth, Index, Depth+1);
                false -> find_coprime1_helper(T, Value, Path, BestSoFar, BestDepth, Index, Depth+1)
              end
          end;
        false -> find_coprime1_helper(T, Value, Path, BestSoFar, BestDepth, Index, Depth+1)
      end
  end.

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).