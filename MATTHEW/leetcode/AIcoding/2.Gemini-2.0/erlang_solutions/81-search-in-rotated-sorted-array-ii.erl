-module(search_rotated_sorted_array_ii).
-export([search/2]).

search(Nums, Target) ->
  search(Nums, Target, 0, length(Nums) - 1).

search(_Nums, _Target, Low, High) when Low > High ->
  false;
search(Nums, Target, Low, High) ->
  Mid = (Low + High) div 2,
  case lists:nth(Mid + 1, Nums) of
    Target ->
      true;
    _ ->
      if lists:nth(Low + 1, Nums) == lists:nth(Mid + 1, Nums) ->
        search(Nums, Target, Low + 1, High) orelse search(Nums, Target, Low, High - 1);
      lists:nth(Low + 1, Nums) < lists:nth(Mid + 1, Nums) ->
        if lists:nth(Low + 1, Nums) =< Target and Target < lists:nth(Mid + 1, Nums) ->
          search(Nums, Target, Low, Mid - 1);
        true ->
          search(Nums, Target, Mid + 1, High)
        end;
      true ->
        if lists:nth(Mid + 1, Nums) < Target and Target =< lists:nth(High + 1, Nums) ->
          search(Nums, Target, Mid + 1, High);
        true ->
          search(Nums, Target, Low, Mid - 1)
        end
      end
  end.