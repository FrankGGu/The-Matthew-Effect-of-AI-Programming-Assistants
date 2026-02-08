-module(sum_of_number_and_its_reverse).
-export([sum_of_number_and_its_reverse/1]).

sum_of_number_and_its_reverse(Num) ->
    sum_of_number_and_its_reverse(Num, 0).

sum_of_number_and_its_reverse(Num, Acc) when Acc > Num ->
    Acc;
sum_of_number_and_its_reverse(Num, Acc) ->
    Reverse = reverse_number(Acc),
    case Acc + Reverse =:= Num of
        true ->
            sum_of_number_and_its_reverse(Num, Acc + 1);
        false ->
            sum_of_number_and_its_reverse(Num, Acc + 1)
    end.

reverse_number(Num) ->
    reverse_number(Num, 0).

reverse_number(0, Acc) ->
    Acc;
reverse_number(Num, Acc) ->
    LastDigit = Num rem 10,
    Remaining = Num div 10,
    reverse_number(Remaining, Acc * 10 + LastDigit).