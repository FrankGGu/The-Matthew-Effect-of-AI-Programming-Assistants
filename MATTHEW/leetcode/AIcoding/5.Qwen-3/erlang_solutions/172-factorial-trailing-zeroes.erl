-module(factorial_trailing_zeroes).
-export([trailing_zeros/1]).

trailing_zeros(N) ->
    count_zeros(N, 0).

count_zeros(0, Acc) ->
    Acc;
count_zeros(N, Acc) ->
    Count = N div 5,
    count_zeros(N div 5, Acc + Count).