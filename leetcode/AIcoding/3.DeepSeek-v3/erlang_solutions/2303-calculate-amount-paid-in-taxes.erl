-spec calculate_tax(Brackets :: [[integer()]], Income :: integer()) -> float().
calculate_tax(Brackets, Income) ->
    calculate_tax(Brackets, Income, 0, 0.0).

calculate_tax([], _Income, _Prev, Tax) ->
    Tax;
calculate_tax([[Upper, Percent] | Rest], Income, Prev, Tax) when Income > Upper ->
    NewTax = Tax + (Upper - Prev) * Percent / 100,
    calculate_tax(Rest, Income, Upper, NewTax);
calculate_tax([[Upper, Percent] | _Rest], Income, Prev, Tax) ->
    Tax + (Income - Prev) * Percent / 100;
calculate_tax(_, _Income, _Prev, Tax) ->
    Tax.