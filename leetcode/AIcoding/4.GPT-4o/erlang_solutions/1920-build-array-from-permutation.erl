-module(solution).
-export([build_array/1]).

build_array(P) ->
    [P[Index] || Index <- lists:seq(0, length(P) - 1)].