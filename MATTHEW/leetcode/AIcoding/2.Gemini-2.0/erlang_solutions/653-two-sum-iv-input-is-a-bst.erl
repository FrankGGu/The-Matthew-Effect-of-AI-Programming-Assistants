-module(two_sum_bst).
-export([find_target/2]).

-spec find_target(Tree :: tree(), K :: integer()) -> boolean().
find_target(Tree, K) ->
  Values = tree_to_list(Tree, []),
  find_sum(Values, K).

tree_to_list(null, Acc) ->
  Acc;
tree_to_list({node, Val, Left, Right}, Acc) ->
  tree_to_list(Left, [Val | tree_to_list(Right, Acc)]).

find_sum([], _) ->
  false;
find_sum([H | T], K) ->
  case lists:member(K - H, T) of
    true -> true;
    false -> find_sum(T, K)
  end.

-type tree() :: null | {node, integer(), tree(), tree()}.