-module(split_array).
-export([can_split_array/1]).

can_split_array(Nums) ->
  can_split_array(Nums, 0, 0, 0).

can_split_array([], _, _, 0) ->
  true;
can_split_array([], _, _, _) ->
  false;
can_split_array([H|T], LeftSum, RightSum, Count) ->
  NewLeftSum = LeftSum + H,
  NewRightSum = RightSum + H,
  case Count + 1 of
    length([H|T]) ->
      false;
    _ ->
      (NewLeftSum == RightSum andalso can_split_array(T, 0, NewRightSum, 0)) orelse
      can_split_array(T, NewLeftSum, RightSum, Count + 1)
  end.