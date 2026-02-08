-module(grid_graph).
-export([construct_2d_grid/2]).

construct_2d_grid(M, N) ->
  Vertices = lists:seq(1, M * N),
  Edges = generate_edges(M, N),
  {Vertices, Edges}.

generate_edges(M, N) ->
  lists:foldl(
    fun(V, Acc) ->
      Edges = get_edges(V, M, N),
      Acc ++ Edges
    end,
    [],
    lists:seq(1, M * N)
  ).

get_edges(V, M, N) ->
  Edges = [],
  Right =
    if V rem N /= 0 then
      [{V, V + 1}]
    else
      []
    end,
  Down =
    if V + N =< M * N then
      [{V, V + N}]
    else
      []
    end,
  Right ++ Down.