-module(solution).
-export([to_hex/1]).

-spec to_hex(integer()) -> unicode:unicode_binary().
to_hex(Num) ->
    case Num of
        0 -> "0";
        _ -> to_hex_helper(Num, [])
    end.

to_hex_helper(0, Acc) -> lists:flatten(Acc);
to_hex_helper(Num, Acc) ->
    HexDigit = integer_to_hex_digit(abs(Num rem 16)),
    to_hex_helper(Num div 16, [HexDigit | Acc]).

integer_to_hex_digit(0) -> $0;
integer_to_hex_digit(1) -> $1;
integer_to_hex_digit(2) -> $2;
integer_to_hex_digit(3) -> $3;
integer_to_hex_digit(4) -> $4;
integer_to_hex_digit(5) -> $5;
integer_to_hex_digit(6) -> $6;
integer_to_hex_digit(7) -> $7;
integer_to_hex_digit(8) -> $8;
integer_to_hex_digit(9) -> $9;
integer_to_hex_digit(10) -> $a;
integer_to_hex_digit(11) -> $b;
integer_to_hex_digit(12) -> $c;
integer_to_hex_digit(13) -> $d;
integer_to_hex_digit(14) -> $e;
integer_to_hex_digit(15) -> $f.
