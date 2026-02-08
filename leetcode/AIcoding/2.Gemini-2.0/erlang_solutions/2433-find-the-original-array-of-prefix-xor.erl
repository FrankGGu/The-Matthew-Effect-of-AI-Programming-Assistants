-module(prefix_xor).
-export([find_original_array/1]).

find_original_array(Pref) ->
  find_original_array(Pref, []).

find_original_array([], Acc) ->
  lists:reverse(Acc);
find_original_array([H|T], Acc) ->
  case Acc of
    [] ->
      find_original_array(T, [H|Acc]);
    [Prev|_] ->
      find_original_array(T, [H bxor Prev|Acc])
  end.