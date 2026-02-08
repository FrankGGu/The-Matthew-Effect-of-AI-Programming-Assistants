-module(jump_game_ii).
-export([jump/1]).

jump(Nums) ->
  jump_helper(Nums, 0, 0, 0).

jump_helper([], _, _, Count) ->
  Count;
jump_helper([_], _, _, Count) ->
  Count;
jump_helper(Nums, Start, End, Count) ->
  MaxReach = lists:foldl(fun(Num, {I, Max}) ->
                                  case (Start + I) =< End of
                                    true ->
                                      {I + 1, Max};
                                    false ->
                                      {I + 1, max(Max, Start + I + Num)}
                                  end
                              end, {0, 0}, Nums),

  {_, MaxReachVal} = MaxReach,

  jump_helper(Nums, End + 1, MaxReachVal, Count + 1).