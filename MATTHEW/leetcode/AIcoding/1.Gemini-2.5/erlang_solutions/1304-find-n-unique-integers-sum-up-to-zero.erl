-module(solution).
-export([sum_zero/1]).

-spec sum_zero(N :: integer()) -> [integer()].
sum_zero(N) ->
    case N rem 2 of
        0 ->
            K = N div 2,
            [I || I <- 1..K] ++ [-I || I <- 1..K];
        1 ->
            K = (N - 1) div 2,
            [0] ++ [I || I <- 1..K] ++ [-I || I <- 1..K]
    end.