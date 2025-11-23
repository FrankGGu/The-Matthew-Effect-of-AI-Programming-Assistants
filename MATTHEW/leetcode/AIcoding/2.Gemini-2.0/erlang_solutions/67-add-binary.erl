-module(add_binary).
-export([add_binary/2]).

add_binary(A, B) ->
  add_binary(A, B, 0, []).

add_binary([], [], Carry, Acc) ->
  case Carry of
    0 -> lists:reverse(Acc);
    1 -> lists:reverse(["1" | Acc])
  end;
add_binary([], B, Carry, Acc) ->
  add_binary(["0"], B, Carry, Acc);
add_binary(A, [], Carry, Acc) ->
  add_binary(A, ["0"], Carry, Acc);
add_binary([AH | AT], [BH | BT], Carry, Acc) ->
  case {AH, BH, Carry} of
    {"0", "0", 0} -> add_binary(AT, BT, 0, ["0" | Acc]);
    {"0", "0", 1} -> add_binary(AT, BT, 0, ["1" | Acc]);
    {"0", "1", 0} -> add_binary(AT, BT, 0, ["1" | Acc]);
    {"0", "1", 1} -> add_binary(AT, BT, 1, ["0" | Acc]);
    {"1", "0", 0} -> add_binary(AT, BT, 0, ["1" | Acc]);
    {"1", "0", 1} -> add_binary(AT, BT, 1, ["0" | Acc]);
    {"1", "1", 0} -> add_binary(AT, BT, 1, ["0" | Acc]);
    {"1", "1", 1} -> add_binary(AT, BT, 1, ["1" | Acc])
  end.