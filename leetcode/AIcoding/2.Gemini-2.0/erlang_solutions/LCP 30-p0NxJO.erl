-module(magictower).
-export([magictower/1]).

magictower(nums) ->
  lists:reverse(solve(nums, 1, [], 0)).

solve([], _, Acc, Health) ->
  case Health < 0 of
    true -> [];
    false -> [lists:reverse(Acc)]
  end;
solve(Nums, Index, Acc, Health) ->
  case Health + lists:nth(Index, Nums) < 0 of
    true ->
      Min = lists:min(Nums),
      MinIndex = lists:keyfind(Min, 1, lists:zip(Nums, lists:seq(1, length(Nums)))),
      case MinIndex =:= false of
        true -> [];
        false ->
          {_, MinIndexVal} = MinIndex,
          NewNums = lists:delete(lists:nth(MinIndexVal, Nums), Nums),
          solve(NewNums, 1, Acc ++ [MinIndexVal], Health)
      end;
    false ->
      NewNums = lists:delete(lists:nth(Index, Nums), Nums),
      solve(NewNums, 1, Acc ++ [Index], Health + lists:nth(Index, Nums))
  end.