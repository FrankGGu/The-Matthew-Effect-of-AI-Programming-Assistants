-module(solution).
-export([paint_grid/2]).

paint_grid(N, M) ->
    (3 * 2) ^ (N * M) rem (10^9 + 7).