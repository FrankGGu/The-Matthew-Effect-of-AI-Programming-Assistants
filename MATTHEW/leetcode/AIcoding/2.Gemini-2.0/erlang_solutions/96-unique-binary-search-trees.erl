-module(unique_bst).
-export([num_trees/1]).

num_trees(N) ->
  num_trees_helper(N, []).

num_trees_helper(0, _) -> 1;
num_trees_helper(1, _) -> 1;
num_trees_helper(N, Cache) ->
  case lists:keyfind(N, 1, Cache) of
    false ->
      Result = lists:foldl(
                 fun(I, Acc) ->
                   Acc + (num_trees_helper(I - 1, Cache) * num_trees_helper(N - I, Cache))
                 end,
                 0,
                 lists:seq(1, N)
               ),
      num_trees_helper(N, [{N, Result} | Cache]);
    {_, Value} ->
      Value
  end.