-spec count_numbers_with_unique_digits(N :: integer()) -> integer().
count_numbers_with_unique_digits(0) -> 1;
count_numbers_with_unique_digits(1) -> 10;
count_numbers_with_unique_digits(N) when N > 10 -> count_numbers_with_unique_digits(10);
count_numbers_with_unique_digits(N) ->
    Total = 10,
    UniqueDigits = 9,
    AvailableNumbers = 9,
    count_numbers_with_unique_digits(N, 2, Total, UniqueDigits, AvailableNumbers).

count_numbers_with_unique_digits(N, K, Total, UniqueDigits, AvailableNumbers) when K =< N ->
    UniqueDigits1 = UniqueDigits * AvailableNumbers,
    Total1 = Total + UniqueDigits1,
    AvailableNumbers1 = AvailableNumbers - 1,
    count_numbers_with_unique_digits(N, K + 1, Total1, UniqueDigits1, AvailableNumbers1);
count_numbers_with_unique_digits(_, _, Total, _, _) ->
    Total.