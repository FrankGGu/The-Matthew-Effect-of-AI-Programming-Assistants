-module(solution).
-export([divide/2]).

divide(X, Y) when Y =:= 0 -> 
    2^31 - 1;
divide(X, Y) -> 
    sign(X) * sign(Y) * div(abs(X), abs(Y)).

sign(0) -> 0;
sign(N) when N > 0 -> 1;
sign(N) when N < 0 -> -1.

abs(N) when N < 0 -> -N;
abs(N) -> N.