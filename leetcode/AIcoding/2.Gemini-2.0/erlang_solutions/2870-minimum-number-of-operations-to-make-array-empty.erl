-module(minimum_operations).
-export([minOperations/1]).

minOperations(Nums) ->
  Counts = lists:foldl(fun(Num, Acc) ->
    case maps:is_key(Num, Acc) of
      true -> maps:update(Num, maps:get(Num, Acc) + 1, Acc);
      false -> maps:put(Num, 1, Acc)
    end
  end, #{}, Nums),

  lists:foldl(fun({_, Count}, Acc) ->
    case Count of
      1 -> -1;
      C when C rem 3 == 0 -> Acc + C div 3;
      C when C rem 3 == 1 -> Acc + (C div 3) - 1 + 2;
      C when C rem 3 == 2 -> Acc + (C div 3) + 1
    end
  end, 0, maps:to_list(Counts)).