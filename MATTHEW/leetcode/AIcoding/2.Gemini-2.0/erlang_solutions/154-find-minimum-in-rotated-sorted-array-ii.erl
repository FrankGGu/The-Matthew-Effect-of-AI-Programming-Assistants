-module(find_min_rotated_sorted_array_ii).
-export([find_min/1]).

find_min(Nums) ->
  find_min(Nums, 0, length(Nums) - 1).

find_min(Nums, Low, High) ->
  if Low >= High ->
    lists:nth(Low + 1, Nums);
  true ->
    Mid = Low + (High - Low) div 2,
    if lists:nth(Low + 1, Nums) < lists:nth(High + 1, Nums) ->
      lists:nth(Low + 1, Nums);
    lists:nth(Low + 1, Nums) == lists:nth(High + 1, Nums) ->
        find_min(Nums, Low + 1, High);
    lists:nth(Mid + 1, Nums) > lists:nth(High + 1, Nums) ->
      find_min(Nums, Mid + 1, High);
    true ->
      find_min(Nums, Low, Mid)
    end
  end.