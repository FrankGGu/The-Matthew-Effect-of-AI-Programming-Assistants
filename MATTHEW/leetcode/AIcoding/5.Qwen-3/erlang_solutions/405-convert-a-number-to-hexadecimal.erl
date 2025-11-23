-module(convert_number_to_hexadecimal).
-export([to_hex/1]).

to_hex(N) when N >= 0 ->
    to_hex(N, []).

to_hex(0, Acc) ->
    case Acc of
        [] -> "0";
        _ -> lists:reverse(Acc)
    end;

to_hex(N, Acc) ->
    Digit = N rem 16,
    Char = case Digit of
        0 -> $0;
        1 -> $1;
        2 -> $2;
        3 -> $3;
        4 -> $4;
        5 -> $5;
        6 -> $6;
        7 -> $7;
        8 -> $8;
        9 -> $9;
        10 -> $a;
        11 -> $b;
        12 -> $c;
        13 -> $d;
        14 -> $e;
        15 -> $f
    end,
    to_hex(N div 16, [Char | Acc]).