-module(solution).
-export([roman_to_int/1]).

roman_to_int(S) ->
    convert(0, S).

convert(Acc, []) ->
    Acc;
convert(Acc, [C1]) ->
    Acc + char_to_int(C1);
convert(Acc, [C1, C2 | Rest]) ->
    Val1 = char_to_int(C1),
    Val2 = char_to_int(C2),
    if
        Val1 < Val2 ->
            convert(Acc + Val2 - Val1, Rest);
        true ->
            convert(Acc + Val1, [C2 | Rest])
    end.

char_to_int(C) ->
    case C of
        'I' -> 1;
        'V' -> 5;
        'X' -> 10;
        'L' -> 50;
        'C' -> 100;
        'D' -> 500;
        'M' -> 1000
    end.