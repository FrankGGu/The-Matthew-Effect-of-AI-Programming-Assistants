-module(solution).
-export([bridge_crossing/1]).

bridge_crossing(Bridges) ->
    lists:sum(Bridges).