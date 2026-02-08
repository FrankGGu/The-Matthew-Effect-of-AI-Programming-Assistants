-module(solution).
-export([replaceElements/1]).

replaceElements(A) ->
    N = length(A),
    replaceElements(A, N, []).

replaceElements([], _, Acc) ->
    lists:reverse(Acc);
replaceElements([H | T], N, Acc) ->
    Max = lists:max(T ++ [H]),
    replaceElements(T, N, [Max | Acc]).