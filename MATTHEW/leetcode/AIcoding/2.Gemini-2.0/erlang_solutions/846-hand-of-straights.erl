-module(hand_of_straights).
-export([isStraightHand/2]).

isStraightHand(Hand, GroupSize) ->
  case length(Hand) rem GroupSize of
    0 ->
      SortedHand = lists:sort(Hand),
      isStraightHandHelper(SortedHand, GroupSize);
    _ ->
      false
  end.

isStraightHandHelper([], _) ->
  true;
isStraightHandHelper(Hand, GroupSize) ->
  First = lists:nth(1, Hand),
  Group = generateGroup(First, GroupSize),
  case checkAndRemoveGroup(Hand, Group) of
    {true, RemainingHand} ->
      isStraightHandHelper(RemainingHand, GroupSize);
    false ->
      false
  end.

generateGroup(Start, GroupSize) ->
  lists:seq(Start, Start + GroupSize - 1).

checkAndRemoveGroup(Hand, Group) ->
  case checkGroup(Hand, Group) of
    true ->
      RemainingHand = removeGroup(Hand, Group),
      {true, RemainingHand};
    false ->
      false
  end.

checkGroup(Hand, Group) ->
  lists:all(fun(X) -> lists:member(X, Hand) end, Group).

removeGroup(Hand, Group) ->
  removeGroupHelper(Hand, Group, []).

removeGroupHelper([], _, Acc) ->
  lists:reverse(Acc);
removeGroupHelper([H|T], Group, Acc) ->
  case lists:member(H, Group) of
    true ->
      removeGroupHelper(T, Group, Acc);
    false ->
      removeGroupHelper(T, Group, [H|Acc])
  end.