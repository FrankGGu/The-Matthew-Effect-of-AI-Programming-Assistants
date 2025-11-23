-module(solution).
-export([min_operations/1]).

min_operations(Conditions) ->
    N = length(Conditions),
    DP = array:new(N, {default, 0}),
    min_operations(Conditions, 0, DP).

min_operations([], _, _) ->
    0;
min_operations([H | T], Index, DP) ->
    Current = array:get(Index, DP),
    Case1 = Current,
    Case2 = if
                Index == 0 -> 1;
                true -> array:get(Index - 1, DP) + 1
            end,
    NewDP = array:set(Index, min(Case1, Case2), DP),
    min_operations(T, Index + 1, NewDP).

min(A, B) when A < B -> A;
min(A, B) -> B.