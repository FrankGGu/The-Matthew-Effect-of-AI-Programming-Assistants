-module(hexadecimal).
-export([to_hex/1]).

to_hex(Num) ->
  to_hex(Num, []).

to_hex(0, Acc) ->
  case Acc of
    [] -> "0";
    _ -> lists:reverse(Acc)
  end;
to_hex(Num, Acc) when Num > 0 ->
  Digit = Num rem 16,
  HexDigit = to_hex_char(Digit),
  to_hex(Num div 16, [HexDigit | Acc]);
to_hex(Num, Acc) ->
  to_hex(Num band 16#FFFFFFFF, Acc).

to_hex_char(Digit) when Digit < 10 ->
  integer_to_list(Digit);
to_hex_char(10) -> "a";
to_hex_char(11) -> "b";
to_hex_char(12) -> "c";
to_hex_char(13) -> "d";
to_hex_char(14) -> "e";
to_hex_char(15) -> "f".