-module(solution).
-export([minOperations/2]).

minOperations(X, A) ->
    N = length(A),
    {MinOps, _} = min_operations(X, A, N, 0, #{}, 0),
    if MinOps =:= infinity -> -1; true -> MinOps end.

min_operations(X, [], _, MinOps, Visited, _) ->
    if X =:= 0 -> {MinOps, Visited};
    true -> {infinity, Visited} end;

min_operations(X, [H | T], N, MinOps, Visited, Index) ->
    NewVisited = maps:put(Index, true, Visited),
    MinOps1 = if maps:is_key(Index, Visited) -> MinOps; true -> MinOps + 1 end,
    NewX = X - H,
    min_operations(NewX, T, N, MinOps1, NewVisited, Index + 1).