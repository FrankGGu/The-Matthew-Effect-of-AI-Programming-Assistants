-module(solution).
-export([num_beautiful_numbers/1]).

num_beautiful_numbers(N) ->
    Count = 0,
    num_beautiful_numbers(1, N, Count).

num_beautiful_numbers(I, N, Count) when I > N ->
    Count;
num_beautiful_numbers(I, N, Count) ->
    case is_beautiful(I) of
        true -> num_beautiful_numbers(I + 1, N, Count + 1);
        false -> num_beautiful_numbers(I + 1, N, Count)
    end.

is_beautiful(N) ->
    Digits = integer_to_list(N),
    Length = length(Digits),
    case Length rem 2 of
        0 -> false;
        _ ->
            FirstHalf = lists:sublist(Digits, (Length - 1) div 2),
            SecondHalf = lists:sublist(Digits, (Length + 1) div 2, Length),
            SumFirst = sum_digits(FirstHalf),
            SumSecond = sum_digits(SecondHalf),
            SumFirst < SumSecond
    end.

sum_digits([]) -> 0;
sum_digits([H | T]) ->
    Digit = list_to_integer([H]),
    Digit + sum_digits(T).