-module(solution).
-export([find_even_numbers/1]).

find_even_numbers(Digits) ->
    DigitsCounts = count_digits(Digits),
    find_even_numbers_recursive(100, DigitsCounts, []).

find_even_numbers_recursive(N, _DigitsCounts, Acc) when N > 999 ->
    lists:reverse(Acc);
find_even_numbers_recursive(N, DigitsCounts, Acc) ->
    D1 = N div 100,
    D2 = (N div 10) rem 10,
    D3 = N rem 10,

    % Check if the last digit is even (already handled by N+2 step, but good for clarity)
    % D3 must be 0, 2, 4, 6, 8
    % D1 must not be 0 (already handled by starting N from 100)

    NumDigits = [D1, D2, D3],
    NumDigitsCounts = count_digits(NumDigits),

    case can_form_number(NumDigitsCounts, DigitsCounts) of
        true ->
            find_even_numbers_recursive(N + 2, DigitsCounts, [N | Acc]);
        false ->
            find_even_numbers_recursive(N + 2, DigitsCounts, Acc)
    end.

count_digits(L) ->
    lists:foldl(fun(D, Acc) -> 
        lists:replace_nth(D + 1, lists:nth(D + 1, Acc) + 1, Acc) 
    end, [0,0,0,0,0,0,0,0,0,0], L).

can_form_number(NumCounts, AvailableCounts) ->
    can_form_number_iter(0, NumCounts, AvailableCounts).

can_form_number_iter(10, _NumCounts, _AvailableCounts) ->
    true;
can_form_number_iter(I, NumCounts, AvailableCounts) ->
    case lists:nth(I + 1, NumCounts) =< lists:nth(I + 1, AvailableCounts) of
        true -> can_form_number_iter(I + 1, NumCounts, AvailableCounts);
        false -> false
    end.