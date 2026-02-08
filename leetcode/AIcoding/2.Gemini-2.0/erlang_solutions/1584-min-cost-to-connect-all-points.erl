-module(min_cost_connect_points).
-export([min_cost_connect_points/1]).

min_cost_connect_points(Points) ->
  N = length(Points),
  Edges = generate_edges(Points, N),
  kruskal(Edges, N).

generate_edges(Points, N) ->
  lists:foldl(
    fun(I, Acc) ->
      lists:foldl(
        fun(J, Acc2) ->
          if I < J then
            Dist = manhattan_distance(lists:nth(I+1, Points), lists:nth(J+1, Points)),
            [{Dist, I, J} | Acc2]
          else
            Acc2
          end
        end,
        Acc,
        lists:seq(0, N-1)
      )
    end,
    [],
    lists:seq(0, N-1)
  ).

manhattan_distance([X1, Y1], [X2, Y2]) ->
  abs(X1 - X2) + abs(Y1 - Y2).

kruskal(Edges, N) ->
  SortedEdges = lists:sort(Edges),
  UF = uf_init(N),
  kruskal_helper(SortedEdges, UF, 0, 0).

kruskal_helper([], _UF, _Cost, _Count) ->
  0;
kruskal_helper([], _UF, Cost, NMinus1) when NMinus1 == N - 1 ->
  Cost;
kruskal_helper([], _UF, _Cost, _Count) ->
  0;
kruskal_helper([{Dist, U, V} | Rest], UF, Cost, NMinus1) ->
  {RootU, UF2} = uf_find(U, UF),
  {RootV, UF3} = uf_find(V, UF2),
  if RootU =:= RootV then
    kruskal_helper(Rest, UF, Cost, NMinus1)
  else
    {NewUF, _} = uf_union(RootU, RootV, UF3),
    kruskal_helper(Rest, NewUF, Cost + Dist, NMinus1 + 1)
  end.

uf_init(N) ->
  [{I, I} || I <- lists:seq(0, N-1)].

uf_find(X, UF) ->
  case lists:keyfind(X, 1, UF) of
    false ->
      {X, UF};
    {X, Y} ->
      if X =:= Y then
        {X, UF}
      else
        {RootY, NewUF} = uf_find(Y, UF),
        NewUF2 = lists:keyreplace(X, 1, UF, {X, RootY}),
        {RootY, NewUF2}
      end
  end.

uf_union(X, Y, UF) ->
  NewUF = lists:map(
    fun({K, V}) ->
      case V of
        X -> {K, Y};
        _ -> {K, V}
      end
    end,
    UF
  ),
  {NewUF, true}.