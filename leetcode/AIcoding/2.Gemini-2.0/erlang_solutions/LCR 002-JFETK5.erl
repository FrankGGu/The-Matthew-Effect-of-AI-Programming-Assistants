-module(binary_sum).
-export([addBinary/2]).

addBinary(A, B) ->
  addBinaryHelper(A, B, 0, []).

addBinaryHelper([], [], 0, Acc) ->
  lists:reverse(Acc);
addBinaryHelper([], [], Carry, Acc) ->
  addBinaryHelper([], [integer_to_list(Carry)], 0, Acc);
addBinaryHelper([], B, Carry, Acc) ->
  addBinaryHelper("0", B, Carry, Acc);
addBinaryHelper(A, [], Carry, Acc) ->
  addBinaryHelper(A, "0", Carry, Acc);
addBinaryHelper([HA|TA], [HB|TB], Carry, Acc) ->
  AVal = list_to_integer([HA]),
  BVal = list_to_integer([HB]),
  Sum = AVal + BVal + Carry,
  case Sum of
    0 ->
      addBinaryHelper(TA, TB, 0, [0 | Acc]);
    1 ->
      addBinaryHelper(TA, TB, 0, [1 | Acc]);
    2 ->
      addBinaryHelper(TA, TB, 1, [0 | Acc]);
    3 ->
      addBinaryHelper(TA, TB, 1, [1 | Acc])
  end.