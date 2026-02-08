-module(solution).
-export([nthPersonGetsNthSeat/1]).

nthPersonGetsNthSeat(N) when N == 1 ->
    1.0;
nthPersonGetsNthSeat(N) when N > 1 ->
    0.5.