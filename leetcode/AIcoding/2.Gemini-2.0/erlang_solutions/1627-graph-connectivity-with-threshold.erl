-module(graph_connectivity_with_threshold).
-export([num_reachable/3]).

num_reachable(N, Threshold, Edges) ->
  Parent = array:new(N+1, {fixed,1}),
  lists:foreach(fun({U,V}) ->
                  case gcd(U,V) > Threshold of
                    true ->
                      union(U,V,Parent);
                    false ->
                      ok
                  end
                end, Edges),

  Root = find(1, Parent),

  lists:foldl(fun({U,V}, Acc) ->
                  if find(U, Parent) == Root,
                     if find(V, Parent) == Root,
                        Acc+1,
                     else
                        Acc
                     else
                       Acc
                  end
              end, 0, Edges).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).

find(I, Parent) ->
  case array:get(I, Parent) of
    I -> I;
    P -> find(P, Parent)
  end.

union(U, V, Parent) ->
  RootU = find(U, Parent),
  RootV = find(V, Parent),
  if RootU /= RootV,
    array:set(RootU, RootV, Parent),
    ok
  else
    ok
  end.