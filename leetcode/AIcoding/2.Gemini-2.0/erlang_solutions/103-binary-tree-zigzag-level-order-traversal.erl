-module(zigzag_level_order).
-export([zigzagLevelOrder/1]).

zigzagLevelOrder(Root) ->
  zigzagLevelOrder(Root, [], 0).

zigzagLevelOrder(null, Acc, _) ->
  lists:reverse(Acc);
zigzagLevelOrder(Root, Acc, Level) ->
  {Val, Left, Right} = Root,
  NextLevel = Level + 1,
  {NextNodes, CurrentLevel} = 
    case Level rem 2 =:= 0 of
      true ->
        {[Left, Right], [Val | lists:nth(Level + 1, [[] | Acc])]} ;
      false ->
        {[Right, Left], [Val | lists:nth(Level + 1, [[] | Acc])]}
    end,
  NewAcc = lists:nthtail(Level + 1, [[] | Acc]),
  NewAcc2 = CurrentLevel ++ NewAcc,
  NewAcc3 = lists:reverse(NewAcc2),
  NewAcc4 = lists:reverse(NewAcc3),
  [L,R] = NextNodes,
  zigzagLevelOrder(L, zigzagLevelOrder(R, NewAcc4, NextLevel), NextLevel).