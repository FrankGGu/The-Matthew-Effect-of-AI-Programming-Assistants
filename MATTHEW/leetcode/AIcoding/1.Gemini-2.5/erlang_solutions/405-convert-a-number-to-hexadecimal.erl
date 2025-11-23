-module(solution).
-export([toHex/1]).

toHex(0) -> "0";
toHex(Num) when Num > 0 ->
    convert(Num, []);
toHex(Num) when Num < 0 ->
    convert(Num + (1 bsl 32), []).

convert(0, Acc) ->
    lists:reverse(Acc);
convert(N, Acc) ->
    Rem = N rem 16,
    Char = to_hex_char(Rem),
    convert(N div 16, [Char | Acc]).

to_hex_char(D) when D >= 0, D <= 9 ->
    $0 + D;
to_hex_char(D) when D >= 10, D <= 15 ->
    $a + (D - 10).