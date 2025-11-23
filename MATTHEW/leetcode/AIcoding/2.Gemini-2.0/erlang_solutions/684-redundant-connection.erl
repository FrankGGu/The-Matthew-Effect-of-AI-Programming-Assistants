-module(redundant_connection).
-export([find_redundant_connection/1]).

find_redundant_connection(Edges) ->
  N = length(Edges);
  {ok, UF} = uf_create(N),
  lists:foldl(fun(Edge, Acc) ->
                [U, V] = Edge,
                if
                  uf_connected(UF, U, V) ->
                    Edge;
                  true ->
                    uf_union(UF, U, V),
                    Acc
                end
              end, [], Edges).

-module(uf).
-export([create/1, connected/3, union/3]).

create(N) ->
  {ok, {lists:seq(1, N), lists:seq(1, N)}}.

connected({_Parent, Rank}, U, V) ->
  find(_Parent, U) == find(_Parent, V).

union({Parent, Rank}, U, V) ->
  RootU = find(Parent, U),
  RootV = find(Parent, V),
  if RootU == RootV ->
    {Parent, Rank}
  else
    if lists:nth(RootU, Rank) < lists:nth(RootV, Rank) ->
      {lists:replace(RootU, Parent, RootV), Rank};
    true ->
      if lists:nth(RootU, Rank) > lists:nth(RootV, Rank) ->
        {lists:replace(RootV, Parent, RootU), Rank};
      true ->
        {lists:replace(RootV, Parent, RootU), lists:replace(RootU, Rank, lists:nth(RootU, Rank) + 1, Rank)}
      end
    end
  end.

find(Parent, X) ->
  Root = find_root(Parent, X);
  {lists:map(fun(Y) -> if lists:nth(Y, Parent) /= Root -> Root else lists:nth(Y,Parent) end, lists:seq(1, length(Parent))), lists:nth(X, Parent)},
  Root.

find_root(Parent, X) ->
  if lists:nth(X, Parent) == X ->
    X
  else
    find_root(Parent, lists:nth(X, Parent))
  end.