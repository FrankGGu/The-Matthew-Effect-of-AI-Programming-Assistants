-module(solution).
-export([intToRoman/1]).

intToRoman(Num) ->
    RomanMap = [
        {1000, "M"},
        {900, "CM"},
        {500, "D"},
        {400, "CD"},
        {100, "C"},
        {90, "XC"},
        {50, "L"},
        {40, "XL"},
        {10, "X"},
        {9, "IX"},
        {5, "V"},
        {4, "IV"},
        {1, "I"}
    ],
    intToRoman_helper(Num, RomanMap, "").

intToRoman_helper(0, _, Acc) ->
    Acc;
intToRoman_helper(Num, [{Value, Symbol} | RestOfMap], Acc) ->
    if
        Num >= Value ->
            intToRoman_helper(Num - Value, [{Value, Symbol} | RestOfMap], Acc ++ Symbol);
        true ->
            intToRoman_helper(Num, RestOfMap, Acc)
    end.