-module(minimum_sum).
-export([minimum_sum/1]).

minimum_sum(N) ->
  Digits = lists:sort([N div 1000, (N div 100) rem 10, (N div 10) rem 10, N rem 10]),
  (lists:nth(1, Digits) + lists:nth(2, Digits)) * 10 + lists:nth(3, Digits) + lists:nth(4, Digits).