-module(height_after_removal).
-export([treeQueries/2]).

treeQueries(Root, Queries) ->
  {Heights, MaxHeights} = calculate_heights(Root),
  [calculate_height_after_removal(Heights, MaxHeights, Q) || Q <- Queries].

calculate_heights(null) ->
  {{}, {}};
calculate_heights({Val, Left, Right}) ->
  {LeftHeights, LeftMaxHeights} = calculate_heights(Left),
  {RightHeights, RightMaxHeights} = calculate_heights(Right),
  LeftHeight = maps:get(Val, LeftHeights, -1),
  RightHeight = maps:get(Val, RightHeights, -1),
  Height = max(LeftHeight + 1, RightHeight + 1),
  Max1 = max(maps:get(1, LeftMaxHeights, -1), maps:get(2, RightHeight + 1, -1)),
  Max2 = max(maps:get(1, RightMaxHeights, -1), maps:get(2, LeftHeight + 1, -1)),
  Heights = maps:put(Val, Height, maps:merge(LeftHeights, RightHeights)),
  MaxHeights = maps:from_list([{1, Height}, {2, max(Max1, Max2)}]),
  {Heights, MaxHeights}.

calculate_height_after_removal(Heights, MaxHeights, Q) ->
  Height = maps:get(Q, Heights, -1),
  case maps:get(1, MaxHeights, -1) =:= Height of
    true -> maps:get(2, MaxHeights, -1);
    false -> maps:get(1, MaxHeights, -1)
  end.