-module(good_leaf_nodes_pairs).
-export([count_pairs/2]).

count_pairs(Root, Distance) ->
  count_pairs_helper(Root, Distance, 0).

count_pairs_helper(null, _, _) ->
  {[], 0};
count_pairs_helper(Tree, Distance, Acc) ->
  case Tree of
    {null, _, null} ->
      {[1], Acc};
    {Left, Val, Right} ->
      {LeftDistances, LeftCount} = count_pairs_helper(Left, Distance, Acc),
      {RightDistances, RightCount} = count_pairs_helper(Right, Distance, Acc),
      NewDistances = lists:append([1 + D || D <- LeftDistances, 1 + D =< Distance],
                                  [1 + D || D <- RightDistances, 1 + D =< Distance]),
      NewAcc = LeftCount + RightCount +
               lists:sum([1 || LD <- LeftDistances, RD <- RightDistances, LD + RD =< Distance]),
      {NewDistances, NewAcc}
  end.