-module(solution).
-export([monotone_increasing_digits/1]).

monotone_increasing_digits(N) ->
    Digits = integer_to_list(N),
    IntDigits = [C - $0 || C <- Digits],
    ResultDigits = fix_digits(IntDigits),
    list_to_integer(ResultDigits).

fix_digits(IntDigits) ->
    Len = length(IntDigits),
    fix_digits_recursive(Len - 2, IntDigits).

fix_digits_recursive(CurrentIdx, CurrentDigits) ->
    if CurrentIdx < 0 ->
        CurrentDigits;
    true ->
        DigitAtCurrent = lists:nth(CurrentIdx + 1, CurrentDigits),
        DigitAtNext = lists:nth(CurrentIdx + 2, CurrentDigits),
        if DigitAtCurrent > DigitAtNext ->
            Prefix = lists:sublist(CurrentDigits, 1, CurrentIdx),
            NewCurrentDigit = DigitAtCurrent - 1,
            SuffixNines = lists:duplicate(length(CurrentDigits) - (CurrentIdx + 1), 9),
            ModifiedDigits = lists:append([Prefix, [NewCurrentDigit], SuffixNines]),
            fix_digits_recursive(CurrentIdx - 1, ModifiedDigits);
        true ->
            fix_digits_recursive(CurrentIdx - 1, CurrentDigits)
        end
    end.

list_to_integer(List) ->
    lists:foldl(fun(D, Acc) -> Acc * 10 + D end, 0, List).