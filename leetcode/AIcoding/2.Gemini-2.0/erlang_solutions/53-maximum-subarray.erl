-module(maximum_subarray).
-export([max_sub_array/1]).

max_sub_array(Nums) ->
  max_sub_array_helper(Nums, hd(Nums), hd(Nums)).

max_sub_array_helper([H|T], CurrentMax, GlobalMax) ->
  NewCurrentMax = max(H, CurrentMax + H),
  NewGlobalMax = max(GlobalMax, NewCurrentMax),
  case T of
    [] ->
      NewGlobalMax;
    _ ->
      max_sub_array_helper(T, NewCurrentMax, NewGlobalMax)
  end.