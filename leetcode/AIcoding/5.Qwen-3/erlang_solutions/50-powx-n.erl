-module(pow_x_n).
-export([pow/2]).

pow(X, N) ->
    pow(X, N, 1).

pow(_, 0, Result) ->
    Result;
pow(X, N, Result) when N > 0 ->
    pow(X, N - 1, X * Result);
pow(X, N, Result) when N < 0 ->
    pow(1/X, -N - 1, 1/X * Result).