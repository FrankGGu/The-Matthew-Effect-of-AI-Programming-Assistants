-module(deep_dark_fraction).
-export([solve/1]).

solve(Nums) ->
    solve(Nums, 0, 0).

solve([], _Numerator, Denominator) ->
    {Denominator, 0};
solve([H | T], Numerator, Denominator) ->
    NewNumerator = Numerator * H + 1,
    NewDenominator = Denominator * H + 1,
    solve(T, NewNumerator, NewDenominator).