-module(clumsy).
-export([clumsy_factorial/1]).

clumsy_factorial(N) ->
    clumsy_factorial(N, 1, 1).

clumsy_factorial(0, _, Result) ->
    Result;
clumsy_factorial(1, _, Result) ->
    Result;
clumsy_factorial(2, _, Result) ->
    Result * 2;
clumsy_factorial(3, _, Result) ->
    Result * 6;
clumsy_factorial(N, Step, Result) when Step rem 4 == 1 ->
    clumsy_factorial(N - 1, Step + 1, Result * N);
clumsy_factorial(N, Step, Result) when Step rem 4 == 2 ->
    clumsy_factorial(N - 1, Step + 1, Result * N);
clumsy_factorial(N, Step, Result) when Step rem 4 == 3 ->
    clumsy_factorial(N - 1, Step + 1, Result div N);
clumsy_factorial(N, Step, Result) when Step rem 4 == 0 ->
    clumsy_factorial(N - 1, Step + 1, Result - N).