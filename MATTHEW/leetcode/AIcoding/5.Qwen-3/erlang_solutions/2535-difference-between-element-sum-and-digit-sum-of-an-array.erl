-module(solution).
-export([difference_between_element_and_digit_sum/1]).

difference_between_element_and_digit_sum(Nums) ->
    ElementSum = lists:sum(Nums),
    DigitSum = lists:foldl(fun(N, Acc) -> Acc + digit_sum(N) end, 0, Nums),
    ElementSum - DigitSum.

digit_sum(0) ->
    0;
digit_sum(N) ->
    N rem 10 + digit_sum(N div 10).