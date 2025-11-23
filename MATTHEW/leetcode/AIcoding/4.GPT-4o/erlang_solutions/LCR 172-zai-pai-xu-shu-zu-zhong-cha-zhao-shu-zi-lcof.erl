-module(solution).
-export([num_occurrences/2]).

num_occurrences(List, Target) ->
    lists:foldl(fun(X, Acc) -> if X =:= Target -> Acc + 1; true -> Acc end end, 0, List).