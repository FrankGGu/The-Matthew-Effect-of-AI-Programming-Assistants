-module(minimum_element_after_replacement_with_digit_sum).
-export([minimum_element_after_replacement_with_digit_sum/1]).

minimum_element_after_replacement_with_digit_sum(Nums) ->
    lists:map(fun(Num) -> replace(Num) end, Nums).

replace(Num) when Num < 10 ->
    Num;
replace(Num) ->
    Sum = digit_sum(Num),
    if Sum < Num then
        replace(Sum)
    else
        Num
    end.

digit_sum(Num) ->
    digit_sum_helper(Num, 0).

digit_sum_helper(0, Acc) ->
    Acc;
digit_sum_helper(Num, Acc) ->
    digit_sum_helper(Num div 10, Acc + (Num rem 10)).