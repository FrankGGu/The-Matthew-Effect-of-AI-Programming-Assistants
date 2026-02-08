-module(solution).
-export([nthUglyNumber/1]).

nthUglyNumber(1) -> 1;
nthUglyNumber(N) ->
    UglyArray = array:new([{size, N}, {fixed, true}]),
    UglyArray0 = array:set(0, 1, UglyArray),

    I2 = 0,
    I3 = 0,
    I5 = 0,

    ugly_number_helper(1, N, UglyArray0, I2, I3, I5).

ugly_number_helper(K, N, UglyArray, I2, I3, I5) when K < N ->
    U2 = array:get(I2, UglyArray) * 2,
    U3 = array:get(I3, UglyArray) * 3,
    U5 = array:get(I5, UglyArray) * 5,

    NextUgly = min(U2, U3, U5),

    NewI2 = if NextUgly == U2 -> I2 + 1; true -> I2 end,
    NewI3 = if NextUgly == U3 -> I3 + 1; true -> I3 end,
    NewI5 = if NextUgly == U5 -> I5 + 1; true -> I5 end,

    NewUglyArray = array:set(K, NextUgly, UglyArray),

    ugly_number_helper(K + 1, N, NewUglyArray, NewI2, NewI3, NewI5);

ugly_number_helper(N, N, UglyArray, _I2, _I3, _I5) ->
    array:get(N - 1, UglyArray).