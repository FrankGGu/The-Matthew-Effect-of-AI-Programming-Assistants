-module(solution).
-export([kth_factor/3]).

kth_factor(N, K) ->
    Factors = [I || I <- lists:seq(1, N), N rem I =:= 0],
    case lists:nth(K, Factors) of
        undefined -> -1;
        Factor -> Factor
    end.