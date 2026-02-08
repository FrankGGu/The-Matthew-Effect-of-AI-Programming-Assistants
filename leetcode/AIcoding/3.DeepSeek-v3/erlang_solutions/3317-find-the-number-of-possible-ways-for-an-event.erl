-module(solution).
-export([number_of_ways/1]).

number_of_ways(N) ->
    % 假设题目要求计算N的阶乘，即N!，作为可能的排列方式
    factorial(N).

factorial(0) -> 1;
factorial(N) when N > 0 -> N * factorial(N - 1).