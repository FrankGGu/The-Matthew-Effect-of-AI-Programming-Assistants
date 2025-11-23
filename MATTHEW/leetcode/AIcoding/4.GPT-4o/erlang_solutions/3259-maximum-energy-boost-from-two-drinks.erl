-module(solution).
-export([max_energy/2]).

max_energy(A, B) ->
    lists:max([A + B, A, B]).