-module(solution).
-export([has_alternating_bits/1]).

has_alternating_bits(N) ->
    X = N band (N bsr 1),
    X == 0.