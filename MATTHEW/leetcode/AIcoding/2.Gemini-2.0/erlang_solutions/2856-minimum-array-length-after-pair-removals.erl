-module(minimum_array_length).
-export([min_array_length/1]).

min_array_length(Nums) ->
  min_array_length(Nums, 0).

min_array_length([], Acc) ->
  Acc;
min_array_length(Nums, Acc) ->
  {Mode, Count} = find_mode(Nums),
  Len = length(Nums),
  if Count > Len div 2 ->
    2 * (Count - (Len - Count))
  otherwise ->
    Len rem 2
  end.

find_mode(Nums) ->
  find_mode(Nums, #{}, 0, undefined).

find_mode([], _, MaxCount, Mode) ->
  {Mode, MaxCount};
find_mode([H | T], Counts, MaxCount, Mode) ->
  NewCounts = maps:update_with(H, fun(X) -> X + 1 end, 1, Counts),
  NewCount = maps:get(H, NewCounts),
  if NewCount > MaxCount ->
    find_mode(T, NewCounts, NewCount, H)
  else ->
    find_mode(T, NewCounts, MaxCount, Mode)
  end.