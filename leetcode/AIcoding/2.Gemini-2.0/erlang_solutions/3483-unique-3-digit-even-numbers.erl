-module(unique_3_digit_even_numbers).
-export([unique_3_digit_even_numbers/1]).

unique_3_digit_even_numbers(Digits) ->
    DigitsSet = sets:from_list(Digits),
    lists:sort(lists:usort([I * 100 + J * 10 + K ||
                                  I <- sets:to_list(DigitsSet),
                                  I > 0,
                                  J <- sets:to_list(DigitsSet),
                                  K <- sets:to_list(DigitsSet),
                                  K rem 2 == 0,
                                  I /= J,
                                  I /= K,
                                  J /= K])).