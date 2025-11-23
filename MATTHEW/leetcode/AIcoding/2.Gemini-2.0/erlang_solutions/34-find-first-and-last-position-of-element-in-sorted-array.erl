-module(find_first_last).
-export([searchRange/2]).

searchRange(Nums, Target) ->
  case Nums of
    [] -> [-1, -1];
    _ ->
      First = find_first(Nums, Target, 0, length(Nums) - 1),
      Last = find_last(Nums, Target, 0, length(Nums) - 1),
      [First, Last]
  end.

find_first(Nums, Target, Low, High) ->
  if Low > High then
    -1
  else
    Mid = Low + (High - Low) div 2,
    case Nums!!Mid of
      Target ->
        if Mid == Low orelse Nums!!(Mid - 1) < Target then
          Mid
        else
          find_first(Nums, Target, Low, Mid - 1)
        end;
      Val when Val < Target ->
        find_first(Nums, Target, Mid + 1, High);
      _ ->
        find_first(Nums, Target, Low, Mid - 1)
    end
  end.

find_last(Nums, Target, Low, High) ->
  if Low > High then
    -1
  else
    Mid = Low + (High - Low) div 2,
    case Nums!!Mid of
      Target ->
        if Mid == High orelse Nums!!(Mid + 1) > Target then
          Mid
        else
          find_last(Nums, Target, Mid + 1, High)
        end;
      Val when Val > Target ->
        find_last(Nums, Target, Low, Mid - 1);
      _ ->
        find_last(Nums, Target, Mid + 1, High)
    end
  end.