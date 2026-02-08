-module(solution).
-export([myPow/2]).

myPow(X, N) when N == 0 ->
    1.0;
myPow(X, N) when N < 0 ->
    1.0 / myPow(X, -N);
myPow(X, N) ->
    pow_positive(X, N).

pow_positive(X, N) when N == 0 ->
    1.0;
pow_positive(X, N) ->
    Half = pow_positive(X, N div 2),
    Result = Half * Half,
    case N rem 2 of
        1 -> Result * X;
        0 -> Result
    end.