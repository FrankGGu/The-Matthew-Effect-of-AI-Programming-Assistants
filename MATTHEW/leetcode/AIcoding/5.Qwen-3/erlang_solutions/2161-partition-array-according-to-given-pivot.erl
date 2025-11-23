-module(partition_array).
-export([pivot_array/2]).

pivot_array(Nums, Pivot) ->
    Left = [X || X <- Nums, X < Pivot],
    Equal = [X || X <- Nums, X == Pivot],
    Right = [X || X <- Nums, X > Pivot],
    Left ++ Equal ++ Right.