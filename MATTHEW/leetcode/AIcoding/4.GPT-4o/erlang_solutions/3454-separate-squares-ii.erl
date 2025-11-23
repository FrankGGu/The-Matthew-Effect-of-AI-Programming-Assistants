-module(solution).
-export([separate_squares/1]).

separate_squares(N) ->
    Lists = [lists:duplicate(M, M) || M <- lists:seq(1, N)],
    flatten(Lists).