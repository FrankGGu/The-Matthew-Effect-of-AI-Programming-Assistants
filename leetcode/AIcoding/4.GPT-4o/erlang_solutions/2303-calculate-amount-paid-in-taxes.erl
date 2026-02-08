-module(solution).
-export([calculate_tax/2]).

calculate_tax(brackets, income) ->
    calculate_tax_helper(brackets, income, 0, 0).

calculate_tax_helper([], _Income, TaxAcc, _) -> 
    TaxAcc;
calculate_tax_helper([{Limit, Percent} | Rest], Income, TaxAcc, PrevLimit) ->
    TaxableIncome = min(Income - PrevLimit, Limit - PrevLimit),
    NewTaxAcc = TaxAcc + (TaxableIncome * Percent div 100),
    if
        Income > Limit -> 
            calculate_tax_helper(Rest, Income, NewTaxAcc, Limit);
        true -> 
            NewTaxAcc
    end.