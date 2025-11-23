-module(solution).
-export([intersect/2]).

intersect(A, B) ->
    Map = maps:from_list([{X, 1} || X <- A]),
    [X || X <- B, maps:is_key(X, Map)].