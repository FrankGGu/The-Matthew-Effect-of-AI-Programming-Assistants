-module(solution).
-export([myPow/2]).

myPow(X, N) when N == 0 ->
    1.0;
myPow(X, N) when X == 0.0 ->
    0.0;
myPow(X, N) when N < 0 ->
    1.0 / pow_helper(X, -N);
myPow(X, N) ->
    pow_helper(X, N).

pow_helper(_, 0) ->
    1.0;
pow_helper(Base, Exp) when Exp rem 2 == 0 ->
    pow_helper(Base * Base, Exp div 2);
pow_helper(Base, Exp) ->
    Base * pow_helper(Base * Base, (Exp - 1) div 2).