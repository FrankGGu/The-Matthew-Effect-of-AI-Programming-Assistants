-module(solution).
-export([minimizeStringLength/1]).

minimizeStringLength(S) ->
    Set = sets:from_list(S),
    sets:size(Set).