-module(solution).
-export([int_to_roman/1]).

int_to_roman(N) ->
    IntToRoman = [
        {1000, "M"}, {900, "CM"}, {500, "D"}, {400, "CD"},
        {100, "C"}, {90, "XC"}, {50, "L"}, {40, "XL"},
        {10, "X"}, {9, "IX"}, {5, "V"}, {4, "IV"}, {1, "I"}
    ],
    convert(N, IntToRoman, []).

convert(0, _, Acc) ->
    lists:reverse(Acc);
convert(N, [{Val, Sym} | Rest], Acc) ->
    if
        N >= Val ->
            convert(N - Val, [{Val, Sym} | Rest], [Sym | Acc]);
        true ->
            convert(N, Rest, Acc)
    end.