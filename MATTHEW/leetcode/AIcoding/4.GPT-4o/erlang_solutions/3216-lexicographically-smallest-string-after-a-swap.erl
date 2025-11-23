-module(solution).
-export([smallest_lexicographic_string/2]).

smallest_lexicographic_string(S, P) ->
    Indexes = lists:map(fun(X) -> element(1, X) end, lists:filter(fun(X) -> element(1, X) =:= true end, lists:zip(P, lists:seq(1, length(P))))),
    SortedIndexes = lists:sort(Indexes),
    NewString = lists:foldl(fun(I, Acc) -> Acc ++ [lists:nth(I, S)] end, [], SortedIndexes),
    lists:flatten(NewString).