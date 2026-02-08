-module(sum_subsequence_widths).
-export([sum_subsequence_widths/1]).

sum_subsequence_widths(A) ->
    Len = length(A),
    Mod = 1000000007,
    SortedA = lists:sort(A),
    sum_subsequence_widths_helper(SortedA, 0, 0, 0, Len, Mod).

sum_subsequence_widths_helper(_A, Index, MinSum, MaxSum, Len, Mod) when Index >= Len ->
    (MaxSum - MinSum) rem Mod;

sum_subsequence_widths_helper(A, Index, MinSum, MaxSum, Len, Mod) ->
    Pow2 = power(2, Index, Mod),
    NewMinSum = (MinSum + (lists:nth(Index + 1, A) * Pow2) rem Mod) rem Mod,
    NewMaxSum = (MaxSum + (lists:nth(Len - Index, A) * Pow2) rem Mod) rem Mod,
    sum_subsequence_widths_helper(A, Index + 1, NewMinSum, NewMaxSum, Len, Mod).

power(Base, Exp, Mod) ->
    power_helper(Base, Exp, 1, Mod).

power_helper(_Base, 0, Acc, _Mod) ->
    Acc;
power_helper(Base, Exp, Acc, Mod) when Exp rem 2 == 0 ->
    NewBase = (Base * Base) rem Mod,
    power_helper(NewBase, Exp div 2, Acc, Mod);
power_helper(Base, Exp, Acc, Mod) ->
    NewAcc = (Acc * Base) rem Mod,
    power_helper(Base, Exp - 1, NewAcc, Mod).