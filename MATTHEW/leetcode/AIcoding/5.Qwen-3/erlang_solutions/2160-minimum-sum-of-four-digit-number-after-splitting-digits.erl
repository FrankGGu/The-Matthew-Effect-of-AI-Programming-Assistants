-module(minimum_sum).
-export([minimum_sum/1]).

minimum_sum(N) ->
    Digits = lists:sort(lists:seq(0, 9)),
    Split = split_digits(N),
    A = lists:nth(1, Split) * 10 + lists:nth(2, Split),
    B = lists:nth(3, Split) * 10 + lists:nth(4, Split),
    A + B.

split_digits(N) ->
    Digits = [N div 1000, (N rem 1000) div 100, (N rem 100) div 10, N rem 10],
    lists:sort(Digits).