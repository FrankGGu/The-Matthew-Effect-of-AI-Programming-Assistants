-module(solution).
-export([mySqrt/1]).

mySqrt(X) when X < 0 -> 0;
mySqrt(X) -> mySqrt_helper(X, 0).

mySqrt_helper(X, Guess) when Guess * Guess > X -> Guess - 1;
mySqrt_helper(X, Guess) -> mySqrt_helper(X, Guess + 1).