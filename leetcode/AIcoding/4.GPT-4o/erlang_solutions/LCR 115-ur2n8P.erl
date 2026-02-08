-module(solution).
-export([reconstruct_sequence/2]).

reconstruct_sequence(P, S) ->
    sort_p = lists:sort(P),
    sorted_s = lists:sort(S),
    lists:map(fun(X) -> lists:nth(X, sorted_s) end, sort_p).