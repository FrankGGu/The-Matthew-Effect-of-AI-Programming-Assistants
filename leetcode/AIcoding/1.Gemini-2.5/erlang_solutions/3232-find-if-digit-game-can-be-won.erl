-module(solution).
-export([can_alice_win/2]).

sum_digits(0) -> 0;
sum_digits(N) when N > 0 ->
    (N rem 10) + sum_digits(N div 10).

can_alice_win(Nums1, Nums2) ->
    TotalSumDigits1 = lists:sum([sum_digits(N) || N <- Nums1]),
    TotalSumDigits2 = lists:sum([sum_digits(N) || N <- Nums2]),
    TotalSumDigits1 > TotalSumDigits2.