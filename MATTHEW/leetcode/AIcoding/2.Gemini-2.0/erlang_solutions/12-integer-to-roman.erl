-module(integer_to_roman).
-export([intToRoman/1]).

intToRoman(Num) ->
    intToRoman(Num, "").

intToRoman(0, Acc) ->
    lists:reverse(Acc);
intToRoman(Num, Acc) when Num >= 1000 ->
    intToRoman(Num - 1000, [$M|Acc]);
intToRoman(Num, Acc) when Num >= 900 ->
    intToRoman(Num - 900, [$C, $M|Acc]);
intToRoman(Num, Acc) when Num >= 500 ->
    intToRoman(Num - 500, [$D|Acc]);
intToRoman(Num, Acc) when Num >= 400 ->
    intToRoman(Num - 400, [$C, $D|Acc]);
intToRoman(Num, Acc) when Num >= 100 ->
    intToRoman(Num - 100, [$C|Acc]);
intToRoman(Num, Acc) when Num >= 90 ->
    intToRoman(Num - 90, [$X, $C|Acc]);
intToRoman(Num, Acc) when Num >= 50 ->
    intToRoman(Num - 50, [$L|Acc]);
intToRoman(Num, Acc) when Num >= 40 ->
    intToRoman(Num - 40, [$X, $L|Acc]);
intToRoman(Num, Acc) when Num >= 10 ->
    intToRoman(Num - 10, [$X|Acc]);
intToRoman(Num, Acc) when Num >= 9 ->
    intToRoman(Num - 9, [$I, $X|Acc]);
intToRoman(Num, Acc) when Num >= 5 ->
    intToRoman(Num - 5, [$V|Acc]);
intToRoman(Num, Acc) when Num >= 4 ->
    intToRoman(Num - 4, [$I, $V|Acc]);
intToRoman(Num, Acc) when Num >= 1 ->
    intToRoman(Num - 1, [$I|Acc]).