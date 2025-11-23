-module(solution).
-export([distribute_repeating_integers/2]).

distribute_repeating_integers(N, A) ->
    M = length(A),
    MaxCount = lists:max(lists:map(fun(X) -> lists:count(X, A) end, A)),
    if
        MaxCount > (N + 1) div 2 -> []
    else
        lists:foldl(fun(X, Acc) -> Acc ++ lists:duplicate(N div MaxCount + if lists:member(X, Acc) -> 1; true -> 0 end, X) end, [], A)
    end.