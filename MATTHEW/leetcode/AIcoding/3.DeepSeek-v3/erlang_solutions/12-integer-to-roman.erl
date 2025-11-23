-spec int_to_roman(Num :: integer()) -> unicode:unicode_binary().
int_to_roman(Num) ->
    Values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1],
    Symbols = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"],
    int_to_roman(Num, Values, Symbols, <<>>).

int_to_roman(0, _, _, Acc) -> Acc;
int_to_roman(Num, [V | Vs], [S | Ss], Acc) when Num >= V ->
    int_to_roman(Num - V, [V | Vs], [S | Ss], <<Acc/binary, S/binary>>);
int_to_roman(Num, [_ | Vs], [_ | Ss], Acc) ->
    int_to_roman(Num, Vs, Ss, Acc).