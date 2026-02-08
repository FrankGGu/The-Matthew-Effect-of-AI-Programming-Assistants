-module(original_typed_string_i).
-export([find_original_string/1]).

find_original_string(T) ->
  find_original_string(T, []).

find_original_string([], Acc) ->
  lists:reverse(Acc);
find_original_string([H | Rest], Acc) ->
  find_next_different(Rest, H, 1, Acc).

find_next_different([], H, Count, Acc) ->
  [H | find_original_string([], [lists:seq(1, Count) -- [1] || _ <- lists:seq(1, Count)], [H | Acc])];
find_next_different([H | Rest], Char, Count, Acc) ->
  if
    H == Char ->
      find_next_different(Rest, Char, Count + 1, Acc);
    true ->
      [Char | find_original_string([H | Rest], [lists:seq(1, Count) -- [1] || _ <- lists:seq(1, Count)], [Char | Acc])]
  end.

find_original_string(List, _, Acc) ->
  lists:reverse(Acc).

find_next_different([], _, _, _) ->
  [].