-module(solution).
-export([min_operations/2]).

min_operations(N, K) ->
    black_balls = N div 2,
    white_balls = N - black_balls,
    max(B, W) where
        B = black_balls - K,
        W = white_balls - K,
        max(X, Y) -> max(X, Y, 0).

max(X, Y, Z) -> 
    if 
        X >= Y, X >= Z -> X;
        Y >= X, Y >= Z -> Y;
        true -> Z 
    end.