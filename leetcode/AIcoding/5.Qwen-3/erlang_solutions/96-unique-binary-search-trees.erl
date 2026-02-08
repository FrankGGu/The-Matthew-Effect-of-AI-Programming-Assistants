-module(unique_binary_search_trees).
-export([num_trees/1]).

num_trees(0) -> 1;
num_trees(N) ->
    lists:foldl(fun(I, Acc) -> Acc + (lists:foldl(fun(J, A) -> A * J end, 1, lists:seq(1, I)) * lists:foldl(fun(J, A) -> A * J end, 1, lists:seq(1, N - I))) end, 0, lists:seq(1, N)).