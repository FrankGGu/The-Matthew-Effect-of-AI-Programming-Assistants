-module(tax).
-export([calculate_tax/2]).

calculate_tax(Income, TaxRates) ->
    calculate_tax(Income, TaxRates, 0, 0).

calculate_tax(_, [], Acc, Total) ->
    Total + Acc;
calculate_tax(Income, [[Lower, Upper, Rate] | Rest], Acc, Total) ->
    if
        Income <= Lower ->
            calculate_tax(Income, Rest, Acc, Total);
        Income > Upper ->
            Amount = Upper - Lower,
            calculate_tax(Income, Rest, Acc + Amount * Rate, Total + Amount * Rate);
        true ->
            Amount = Income - Lower,
            calculate_tax(Income, Rest, Acc + Amount * Rate, Total + Amount * Rate)
    end.