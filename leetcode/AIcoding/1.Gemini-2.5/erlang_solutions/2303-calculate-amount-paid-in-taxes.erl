-module(solution).
-export([calculate_tax/2]).

calculate_tax(Brackets, Income) ->
    calculate_tax_recursive(Brackets, Income, 0, 0.0).

calculate_tax_recursive([], _Income, _PreviousUpper, TotalTax) ->
    TotalTax;
calculate_tax_recursive([[Upper, Percent] | Rest], Income, PreviousUpper, CurrentTotalTax) ->
    TaxableInBracket = min(Income, Upper) - PreviousUpper,

    NewTotalTax = if
        TaxableInBracket > 0 ->
            CurrentTotalTax + (TaxableInBracket * Percent) / 100.0;
        true ->
            CurrentTotalTax
    end,

    if
        Income =< Upper ->
            NewTotalTax;
        true ->
            calculate_tax_recursive(Rest, Income, Upper, NewTotalTax)
    end.