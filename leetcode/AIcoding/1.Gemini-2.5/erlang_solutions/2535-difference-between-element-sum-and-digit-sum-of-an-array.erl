-module(solution).
-export([solution/1]).

solution(Nums) ->
    ElementSum = lists:sum(Nums),
    DigitSum = lists:foldl(fun(N, Acc) -> Acc + sum_digits_of_number(N) end, 0, Nums),
    abs(ElementSum - DigitSum).

sum_digits_of_number(0) -> 0;
sum_digits_of_number(N) when N > 0 ->
    (N rem 10) + sum_digits_of_number(N div 10).