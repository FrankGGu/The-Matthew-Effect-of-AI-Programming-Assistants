-module(solution).
-export([beautifulArray/1]).

beautifulArray(1) ->
    [1];
beautifulArray(N) ->
    N_odd = (N + 1) div 2,
    N_even = N div 2,
    OddList = beautifulArray(N_odd),
    EvenList = beautifulArray(N_even),
    TransformedOdd = [2*X - 1 || X <- OddList],
    TransformedEven = [2*X || X <- EvenList],
    TransformedOdd ++ TransformedEven.