-module(solution).
-export([separate_squares/1]).

separate_squares(Nums) ->
    {Squares, NonSquares} = lists:partition(fun(X) -> is_square(X) end, Nums),
    Squares ++ NonSquares.

is_square(X) ->
    Root = round(math:sqrt(X)),
    Root * Root == X.