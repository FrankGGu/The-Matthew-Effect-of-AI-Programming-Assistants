-module(get_maximum_generated).
-export([get_maximum_generated/1]).

get_maximum_generated(N) ->
  if N =< 1 ->
    N
  else
    Nums = array:new({1, N+1}, {fixed, 0}),
    array:set(0, Nums, 0),
    array:set(1, Nums, 1),

    Max = lists:foldl(
      fun(I, Acc) ->
        if 2 * I =< N ->
          Val2I = array:get(I, Nums);
          array:set(2 * I, Nums, Val2I),
          if 2 * I + 1 =< N ->
            Val2IPlus1 = Val2I + array:get(I, Nums,Val2I);
            array:set(2 * I + 1, Nums, Val2IPlus1),
            max(Acc, Val2IPlus1)
          else
            Acc
          end
        else
          Acc
        end
      end,
      1,
      lists:seq(1, N div 2)),
    Max
  end.