-module(solution).
-export([add_to_array_form/2]).

add_to_array_form(A, K) ->
  add_to_array_form(A, K, 0, []).

add_to_array_form([], 0, 0, Acc) -> lists:reverse(Acc);
add_to_array_form([], 0, Carry, Acc) -> add_to_array_form([], Carry, 0, Acc);
add_to_array_form([], K, Carry, Acc) ->
  Digit = (K rem 10) + Carry,
  NewCarry = Digit div 10,
  NewDigit = Digit rem 10,
  add_to_array_form([], K div 10, NewCarry, [NewDigit | Acc]);
add_to_array_form(A, K, Carry, Acc) ->
  [H | T] = lists:reverse(A),
  Digit = H + (K rem 10) + Carry,
  NewCarry = Digit div 10,
  NewDigit = Digit rem 10,
  add_to_array_form(lists:reverse(T), K div 10, NewCarry, [NewDigit | Acc]).