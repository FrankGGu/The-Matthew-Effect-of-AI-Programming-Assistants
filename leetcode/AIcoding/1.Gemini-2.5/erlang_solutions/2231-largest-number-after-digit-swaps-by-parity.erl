-module(solution).
-export([largest_number_after_digit_swaps_by_parity/1]).

largest_number_after_digit_swaps_by_parity(Num) ->
    Digits = int_to_digits(Num),
    {Parities, OddDigits, EvenDigits} = extract_parities_and_digits(Digits, [], [], []),

    SortedOdd = lists:sort(fun(A, B) -> A >= B end, OddDigits),
    SortedEven = lists:sort(fun(A, B) -> A >= B end, EvenDigits),

    reconstruct_number(Parities, SortedOdd, SortedEven, 0).

int_to_digits(0) -> [];
int_to_digits(N) -> int_to_digits(N div 10) ++ [N rem 10].

extract_parities_and_digits([], AccParities, AccOdd, AccEven) ->
    {lists:reverse(AccParities), lists:reverse(AccOdd), lists:reverse(AccEven)};
extract_parities_and_digits([H|T], AccParities, AccOdd, AccEven) ->
    if
        H rem 2 == 0 -> % Even
            extract_parities_and_digits(T, [0|AccParities], AccOdd, [H|AccEven]);
        true -> % Odd
            extract_parities_and_digits(T, [1|AccParities], [H|AccOdd], AccEven)
    end.

reconstruct_number([], _SortedOdd, _SortedEven, Acc) ->
    Acc;
reconstruct_number([1|ParityTail], [OddHead|OddTail], EvenList, Acc) ->
    reconstruct_number(ParityTail, OddTail, EvenList, Acc * 10 + OddHead);
reconstruct_number([0|ParityTail], OddList, [EvenHead|EvenTail], Acc) ->
    reconstruct_number(ParityTail, OddList, EvenTail, Acc * 10 + EvenHead).