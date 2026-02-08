-module(solution).
-export([smallestDivisibleDigitProductII/1]).

smallestDivisibleDigitProductII(N) when N == 1 -> 1;
smallestDivisibleDigitProductII(N) ->
    {RemainingN, Digits} = factorize_helper(N, []),
    case RemainingN of
        1 ->
            SortedDigits = lists:sort(Digits),
            CharList = lists:flatmap(fun(D) -> integer_to_list(D) end, SortedDigits),
            list_to_integer(CharList);
        _ ->
            -1
    end.

factorize_helper(1, AccDigits) -> {1, AccDigits};
factorize_helper(CurrentN, AccDigits) ->
    find_largest_divisor(CurrentN, 9, AccDigits).

find_largest_divisor(CurrentN, D, AccDigits) when D >= 2 ->
    if CurrentN rem D == 0 ->
        factorize_helper(CurrentN div D, [D | AccDigits]);
    true ->
        find_largest_divisor(CurrentN, D - 1, AccDigits)
    end;
find_largest_divisor(CurrentN, _D, AccDigits) ->
    {CurrentN, AccDigits}.