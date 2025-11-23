-module(special_array_ii).
-export([special_array/1]).

special_array(Nums) ->
  special_array(Nums, 0, length(Nums)).

special_array(Nums, Low, High) ->
  if Low > High ->
    -1;
  true ->
    Mid = (Low + High) div 2,
    Count = count_greater_equal(Nums, Mid),
    if Count =:= Mid ->
      Mid;
    true ->
      if Count > Mid ->
        special_array(Nums, Mid + 1, High);
      true ->
        special_array(Nums, Low, Mid - 1)
      end
    end
  end.

count_greater_equal(Nums, Val) ->
  count_greater_equal(Nums, Val, 0).

count_greater_equal([], _, Acc) ->
  Acc;
count_greater_equal([H|T], Val, Acc) ->
  if H >= Val ->
    count_greater_equal(T, Val, Acc + 1);
  true ->
    count_greater_equal(T, Val, Acc)
  end.