-module(solution).
-export([minimum_sum/1]).

minimum_sum(Num) ->
    D1 = Num rem 10,
    Rem1 = Num div 10,
    D2 = Rem1 rem 10,
    Rem2 = Rem1 div 10,
    D3 = Rem2 rem 10,
    Rem3 = Rem2 div 10,
    D4 = Rem3 rem 10,

    Digits = lists:sort([D1, D2, D3, D4]),

    [A, B, C, D] = Digits,

    (A * 10 + C) + (B * 10 + D).