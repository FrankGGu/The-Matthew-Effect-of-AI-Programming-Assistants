-module(solution).
-export([permute/1]).

permute(List) ->
    permute(List, []).

permute([], Acc) ->
    [Acc];
permute(List, Acc) ->
    lists:flatmap(fun(X) ->
        permute(lists:delete(X, List), [X | Acc])
    end, List).