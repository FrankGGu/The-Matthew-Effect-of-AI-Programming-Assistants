-module(peak_index_in_mountain_array).
-export([peak_index_in_mountain_array/1]).

peak_index_in_mountain_array(Arr) ->
  peak_index_in_mountain_array(Arr, 0, length(Arr) - 1).

peak_index_in_mountain_array(Arr, Low, High) ->
  if Low =:= High ->
    Low;
  true ->
    Mid = Low + (High - Low) div 2,
    if Arr !! Mid < Arr !! (Mid + 1) ->
      peak_index_in_mountain_array(Arr, Mid + 1, High);
    true ->
      peak_index_in_mountain_array(Arr, Low, Mid)
    end
  end.