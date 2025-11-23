-module(transformed_array).
-export([sortTransformedArray/3]).

sortTransformedArray(Nums, A, B) ->
  N = length(Nums),
  Transformed = [A * X * X + B * X | X <- Nums],
  lists:sort(Transformed).