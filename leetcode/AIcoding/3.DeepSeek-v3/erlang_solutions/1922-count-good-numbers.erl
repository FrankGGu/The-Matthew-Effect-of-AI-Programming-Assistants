-module(solution).
-export([count_good_numbers/1]).

count_good_numbers(N) ->
    EvenPos = (N + 1) div 2,
    OddPos = N div 2,
    PowEven = pow(5, EvenPos),
    PowOdd = pow(4, OddPos),
    (PowEven * PowOdd) rem 1000000007.

pow(_, 0) -> 1;
pow(X, 1) -> X rem 1000000007;
pow(X, N) when N rem 2 == 0 ->
    Y = pow(X, N div 2),
    (Y * Y) rem 1000000007;
pow(X, N) ->
    Y = pow(X, N div 2),
    (Y * Y * X) rem 1000000007.