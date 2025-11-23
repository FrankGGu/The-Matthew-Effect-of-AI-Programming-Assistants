-module(find_key).
-export([find_key/1]).

find_key(Numbers) ->
  find_key(Numbers, []).

find_key([], Acc) ->
  lists:sort(lists:usort(Acc));
find_key([H | T], Acc) ->
  find_key(T, Acc ++ find_key_for_number(H)).

find_key_for_number(Number) ->
  find_key_for_number(Number, []).

find_key_for_number(0, Acc) ->
    [0 | Acc];
find_key_for_number(Number, Acc) when Number > 0 ->
  Remainder = Number rem 10,
  find_key_for_number(Number div 10, [Remainder | Acc]).