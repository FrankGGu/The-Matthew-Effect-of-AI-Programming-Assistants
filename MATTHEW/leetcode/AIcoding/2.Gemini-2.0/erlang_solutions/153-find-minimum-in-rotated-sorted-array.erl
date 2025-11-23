-module(find_min_rotated_array).
-export([find_min/1]).

find_min(Nums) ->
  find_min_helper(Nums, 0, length(Nums) - 1).

find_min_helper(Nums, Low, High) ->
  if Low > High ->
    throw(error)
  else if Low == High ->
    lists:nth(Low + 1, Nums)
  else
    Mid = Low + (High - Low) div 2,
    if lists:nth(Mid + 1, Nums) > lists:nth(High + 1, Nums) ->
      find_min_helper(Nums, Mid + 1, High)
    else
      find_min_helper(Nums, Low, Mid)
    end
  end.