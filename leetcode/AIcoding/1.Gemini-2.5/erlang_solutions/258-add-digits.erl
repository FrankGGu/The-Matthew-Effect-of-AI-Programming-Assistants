-module(solution).
-export([addDigits/1]).

addDigits(0) -> 0;
addDigits(Num) -> 1 + (Num - 1) rem 9.