-module(solution).
-export([count_expected/4]).

count_expected(Nums, S, M, L) ->
    length([X || X <- Nums, X == S orelse X == M orelse X == L]).