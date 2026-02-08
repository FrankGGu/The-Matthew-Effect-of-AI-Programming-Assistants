-module(solution).
-export([colorTheGrid/2]).

colorTheGrid(N, M) ->
    ColorPatterns = 3 * 2^(M - 1) * (2 * M - 1),
    ColorPatterns rem (10^9 + 7).