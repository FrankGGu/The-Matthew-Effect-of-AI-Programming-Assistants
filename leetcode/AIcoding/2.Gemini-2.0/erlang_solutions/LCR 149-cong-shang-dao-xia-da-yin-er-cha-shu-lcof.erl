-module(solution).
-export([solve/1]).

solve(Records) ->
  lists:usort(Records).