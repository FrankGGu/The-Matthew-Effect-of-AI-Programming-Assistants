-module(jump_game).
-export([can_jump/1]).

can_jump(Nums) ->
  can_jump_helper(Nums, 0, 0).

can_jump_helper(Nums, Index, Reachable) ->
  case Index > Reachable of
    true ->
      false;
    false ->
      case Index >= length(Nums) - 1 of
        true ->
          true;
        false ->
          NewReachable = max(Reachable, Index + lists:nth(Index + 1, Nums)),
          can_jump_helper(Nums, Index + 1, NewReachable)
      end
  end.