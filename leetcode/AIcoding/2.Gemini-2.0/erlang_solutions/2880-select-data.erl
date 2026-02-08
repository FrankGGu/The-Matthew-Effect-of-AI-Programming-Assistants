-module(solution).
-export([solve/1]).

solve(Records) ->
  [#{id => R#record.id, name => R#record.name} || R <- Records].