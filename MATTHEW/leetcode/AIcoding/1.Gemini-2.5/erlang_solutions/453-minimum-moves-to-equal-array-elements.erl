-module(solution).
-export([min_moves/1]).

-spec min_moves(Nums :: [integer()]) -> integer().
min_moves(Nums) ->
    Sum = lists:sum(Nums),
    Min = lists:min(Nums),
    N = length(Nums),
    Sum - N * Min.