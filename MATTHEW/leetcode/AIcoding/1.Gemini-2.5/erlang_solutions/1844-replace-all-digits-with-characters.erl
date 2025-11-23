-module(solution).
-export([replace_digits/1]).

replace_digits([]) -> [];
replace_digits([Char, Digit | Rest]) ->
    NewDigitChar = Char + (Digit - $0),
    [Char, NewDigitChar | replace_digits(Rest)].