-module(solution).
-export([add_to_array_form/2]).

add_to_array_form(Num, K) ->
    IntNum = lists:foldl(fun(Digit, Acc) -> Acc * 10 + Digit end, 0, Num),
    Sum = IntNum + K,
    int_to_digits(Sum).

int_to_digits(0) ->
    [0];
int_to_digits(N) when N > 0 ->
    int_to_digits_acc(N, []).

int_to_digits_acc(0, Acc) ->
    Acc;
int_to_digits_acc(N, Acc) ->
    Digit = N rem 10,
    Remaining = N div 10,
    int_to_digits_acc(Remaining, [Digit | Acc]).