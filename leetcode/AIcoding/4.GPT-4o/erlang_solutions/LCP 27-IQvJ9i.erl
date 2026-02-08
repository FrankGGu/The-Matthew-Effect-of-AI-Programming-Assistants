-module(solution).
-export([hit_bulb/3]).

hit_bulb(N, M, P) ->
    case P rem (2 * (N + M)) of
        R when R < N -> {R, 0};
        R when R < (N + M) -> {N - 1, R - N};
        R when R < (2 * N + M) -> {2 * N - R - 1, M - 1};
        R -> {0, 2 * M - R - 1}
    end.