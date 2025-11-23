-module(solution).
-export([letter_combinations/1]).

letter_combinations("") -> [];
letter_combinations(Digits) ->
    combine(Digits).

combine("") -> [""];
combine([H|T]) ->
    LettersH = digit_to_letters(H),
    CombinationsT = combine(T),
    [ [L|C] || L <- LettersH, C <- CombinationsT ].

digit_to_letters(C) when C == $2 -> "abc";
digit_to_letters(C) when C == $3 -> "def";
digit_to_letters(C) when C == $4 -> "ghi";
digit_to_letters(C) when C == $5 -> "jkl";
digit_to_letters(C) when C == $6 -> "mno";
digit_to_letters(C) when C == $7 -> "pqrs";
digit_to_letters(C) when C == $8 -> "tuv";
digit_to_letters(C) when C == $9 -> "wxyz".