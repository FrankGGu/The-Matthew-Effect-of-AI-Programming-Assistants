-module(solution).
-export([smallest_equal_index/1]).

smallest_equal_index(Nums) ->
    smallest_equal_index_helper(Nums, 0, length(Nums)).

smallest_equal_index_helper(_Nums, I, Len) when I == Len ->
    -1;
smallest_equal_index_helper(Nums, I, Len) ->
    DigitSum = sum_digits(I),
    CurrentNum = lists:nth(I + 1, Nums),
    case DigitSum == CurrentNum of
        true -> I;
        false -> smallest_equal_index_helper(Nums, I + 1, Len)
    end.

sum_digits(N) when N < 10 -> N;
sum_digits(N) -> (N rem 10) + sum_digits(N div 10).