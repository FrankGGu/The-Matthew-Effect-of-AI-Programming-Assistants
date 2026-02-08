-module(continuous_array).
-export([find_max_length/1]).

find_max_length(Nums) ->
  find_max_length(Nums, 0, #{0 => -1}, 0).

find_max_length([], _, _, MaxLength) ->
  MaxLength;
find_max_length([Num | Rest], Index, CountMap, MaxLength) ->
  Count = case Num of
            0 -> -1;
            1 -> 1
          end,
  NewCount = maps:get(0, CountMap, 0) + Count,
  case maps:is_key(NewCount, CountMap) of
    true ->
      PrevIndex = maps:get(NewCount, CountMap),
      NewMaxLength = max(MaxLength, Index - PrevIndex);
    false ->
      NewMaxLength = MaxLength
  end,
  NewCountMap = maps:put(NewCount, Index, CountMap),
  find_max_length(Rest, Index + 1, NewCountMap, NewMaxLength).