-module(digit_one).
-export([count_digit_one/1]).

count_digit_one(N) ->
    count_digit_one(N, 0, 1).

count_digit_one(0, Acc, _) ->
    Acc;
count_digit_one(N, Acc, M) ->
    Digit = N rem 10,
    NewN = N div 10,
    case Digit of
        0 ->
            count_digit_one(NewN, Acc + NewN * M, M * 10);
        1 ->
            count_digit_one(NewN, Acc + NewN * M + (M-1) + 1, M * 10);
        _ ->
            count_digit_one(NewN, Acc + (NewN + 1) * M, M * 10)
    end.