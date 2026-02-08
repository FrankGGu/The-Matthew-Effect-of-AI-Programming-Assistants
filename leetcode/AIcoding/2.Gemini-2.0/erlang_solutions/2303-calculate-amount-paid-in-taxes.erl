-module(solution).
-export([calculate_tax/1]).

calculate_tax(Brackets) ->
    calculate_tax(Brackets, 0, 0).

calculate_tax([], _, Amount) ->
    Amount.

calculate_tax([[Upper, Percent]|Rest], Income, Amount) ->
    case Income >= Upper of
        true ->
            calculate_tax(Rest, Upper, Amount + (Upper * Percent / 100));
        false ->
            calculate_tax(Rest, Income, Amount + (Income * Percent / 100))
    end.

calculate_tax(Brackets, Income, Amount) ->
    calculate_tax_helper(Brackets, Income, Amount, 0).

calculate_tax_helper([], _, Amount, _) ->
    Amount.

calculate_tax_helper([[Upper, Percent]|Rest], Income, Amount, PreviousUpper) ->
    TaxableAmount = min(Income - PreviousUpper, Upper - PreviousUpper),
    case TaxableAmount > 0 of
        true ->
            calculate_tax_helper(Rest, Income, Amount + (TaxableAmount * Percent / 100), Upper);
        false ->
            calculate_tax_helper(Rest, Income, Amount, Upper)
    end.

-module(leetcode).
-export([calculate_tax/2]).

calculate_tax(Brackets, Income) ->
    calculate_tax_internal(Brackets, Income, 0, 0).

calculate_tax_internal([], _, Amount, _) ->
    Amount.

calculate_tax_internal([[Upper, Percent]|Rest], Income, Amount, PreviousUpper) ->
    TaxableAmount = min(Income - PreviousUpper, Upper - PreviousUpper),
    case TaxableAmount > 0 of
        true ->
            calculate_tax_internal(Rest, Income, Amount + (TaxableAmount * Percent / 100), Upper);
        false ->
            calculate_tax_internal(Rest, Income, Amount, Upper)
    end.