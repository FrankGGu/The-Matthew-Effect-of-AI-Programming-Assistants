-module(number_of_digit_one).
-export([count_digit_one/1]).

count_digit_one(N) -> count_digit_one(N, 1, 0).

count_digit_one(0, _, Acc) -> Acc;
count_digit_one(N, Power, Acc) ->
    Current = N rem (Power * 10),
    Higher = N div (Power * 10),
    CurrentDigit = (N div Power) rem 10,
    Lower = N rem Power,
    case CurrentDigit of
        0 -> count_digit_one(N, Power * 10, Acc);
        1 -> count_digit_one(N, Power * 10, Acc + Lower + 1);
        _ -> count_digit_one(N, Power * 10, Acc + Higher * Power)
    end.