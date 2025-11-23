-module(permutations).
-export([permute/1]).

permute(Nums) ->
  lists:sort(perm(Nums)).

perm([]) ->
  [[]];
perm(List) ->
  [ [H|T] || H <- List, T <- perm(List -- [H]) ].