-module(min_moves).
-export([min_moves/1]).

min_moves(Nums) ->
  Min = lists:min(Nums),
  lists:sum([N - Min || N <- Nums]).