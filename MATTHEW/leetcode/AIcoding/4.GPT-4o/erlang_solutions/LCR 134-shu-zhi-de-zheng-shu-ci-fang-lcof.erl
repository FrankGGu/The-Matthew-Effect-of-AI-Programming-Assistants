-module(solution).
-export([myPow/2]).

myPow(X, N) when N < 0 -> 1 / myPow(X, -N);
myPow(_, 0) -> 1;
myPow(X, N) when N rem 2 == 0 -> 
    HalfPow = myPow(X, N div 2),
    HalfPow * HalfPow;
myPow(X, N) -> 
    X * myPow(X, N - 1).