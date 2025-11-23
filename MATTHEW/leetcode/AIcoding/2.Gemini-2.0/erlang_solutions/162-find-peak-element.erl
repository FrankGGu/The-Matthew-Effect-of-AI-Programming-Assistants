-module(find_peak_element).
-export([find_peak_element/1]).

find_peak_element(Nums) ->
  find_peak_element(Nums, 0, length(Nums) - 1).

find_peak_element(Nums, L, R) ->
  if L == R ->
    L;
  true ->
    Mid = L + (R - L) div 2,
    if element(Nums, Mid) > element(Nums, Mid + 1) ->
      find_peak_element(Nums, L, Mid);
    true ->
      find_peak_element(Nums, Mid + 1, R)
    end
  end.

element(Nums, Index) ->
  try
    lists:nth(Index + 1, Nums)
  catch
    _:_ ->
      -infinity
  end.