-module(subsets).
-export([subsets/1]).

subsets([]) -> [[]];
subsets([H|T]) ->
    Subs = subsets(T),
    [ [H | S] || S <- Subs ] ++ Subs.