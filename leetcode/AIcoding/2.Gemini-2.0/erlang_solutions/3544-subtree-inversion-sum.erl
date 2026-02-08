-module(subtree_inversion_sum).
-export([subtree_inversion_sum/1]).

-record(tree_node, {val, left, right}).

subtree_inversion_sum(Root) ->
  subtree_inversion_sum_helper(Root, 0).

subtree_inversion_sum_helper(null, Acc) ->
  {Acc, 0};
subtree_inversion_sum_helper(#tree_node{val = Val, left = Left, right = Right}, Acc) ->
  {LeftSum, LeftInversions} = subtree_inversion_sum_helper(Left, 0),
  {RightSum, RightInversions} = subtree_inversion_sum_helper(Right, 0),
  Inversions = count_inversions([Val | lists:flatten([to_list(Left), to_list(Right)])]),
  TotalInversions = Inversions + LeftInversions + RightInversions,
  Sum = Val + LeftSum + RightSum,
  {Sum, TotalInversions}.

to_list(null) ->
  [];
to_list(#tree_node{val = Val, left = Left, right = Right}) ->
  [Val | lists:flatten([to_list(Left), to_list(Right)])].

count_inversions(List) ->
  count_inversions_helper(List, 0).

count_inversions_helper([], Acc) ->
  Acc;
count_inversions_helper([H | T], Acc) ->
  NewAcc = Acc + count_smaller(H, T),
  count_inversions_helper(T, NewAcc).

count_smaller(_H, []) ->
  0;
count_smaller(H, [X | T]) ->
  case H > X of
    true ->
      1 + count_smaller(H, T);
    false ->
      count_smaller(H, T)
  end.