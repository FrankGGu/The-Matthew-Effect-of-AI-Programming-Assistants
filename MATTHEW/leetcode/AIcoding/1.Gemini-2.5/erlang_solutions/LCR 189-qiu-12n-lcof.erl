-module(solution).
-export([sumNums/1]).

sumNums(0) -> 0;
sumNums(N) -> N + sumNums(N - 1).