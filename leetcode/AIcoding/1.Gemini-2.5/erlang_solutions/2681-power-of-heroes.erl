-module(power_of_heroes).
-export([sum_of_powers/1]).

sum_of_powers(Nums) ->
    SortedNums = lists:sort(Nums),
    Mod = 1000000007,
    calculate_sum(SortedNums, 0, 0, Mod).

calculate_sum([], TotalPower, _SumMinContributions, _Mod) ->
    TotalPower;
calculate_sum([H | T], TotalPower, SumMinContributions, Mod) ->
    H_val = H,
    H_squared = (H_val * H_val) rem Mod,
    H_cubed = (H_squared * H_val) rem Mod,

    OtherMinContributions = (H_squared * SumMinContributions) rem Mod,

    CurrentElementPower = (H_cubed + OtherMinContributions) rem Mod,
    NewTotalPower = (TotalPower + CurrentElementPower) rem Mod,

    NewSumMinContributions = ((2 * SumMinContributions) rem Mod + H_val) rem Mod,

    calculate_sum(T, NewTotalPower, NewSumMinContributions, Mod).