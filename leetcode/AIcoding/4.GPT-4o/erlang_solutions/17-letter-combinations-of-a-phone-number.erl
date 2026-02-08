-spec letter_combinations(Digits :: unicode:unicode_binary()) -> [unicode:unicode_binary()].
letter_combinations(Digits) when byte_size(Digits) == 0 -> [];
letter_combinations(Digits) ->
    DigitsList = string:split(Digits, ""),
    letter_combinations(DigitsList, ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]).

letter_combinations([], Acc) -> Acc;
letter_combinations([H | T], Acc) ->
    case lists:nth(H, ["2", "3", "4", "5", "6", "7", "8", "9"]) of
        [] -> letter_combinations(T, Acc);
        Letters -> 
            NewCombinations = [concat(Combo, Letter) || Combo <- Acc, Letter <- Letters],
            letter_combinations(T, NewCombinations)
    end.
