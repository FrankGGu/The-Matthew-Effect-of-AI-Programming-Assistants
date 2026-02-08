-module(solution).
-export([k_concatenation_max_sum/2]).

-define(MOD, 1000000007).

kadane([H|T]) ->
    kadane_acc(T, H, H).

kadane_acc([], MaxSoFar, _CurrentMax) ->
    MaxSoFar;
kadane_acc([H|T], MaxSoFar, CurrentMax) ->
    NewCurrentMax = max(H, CurrentMax + H),
    NewMaxSoFar = max(MaxSoFar, NewCurrentMax),
    kadane_acc(T, NewMaxSoFar, NewCurrentMax).

pmod(Val, Mod) ->
    Res = Val rem Mod,
    if Res < 0 -> Res + Mod;
       true -> Res
    end.

k_concatenation_max_sum(Arr, K) ->
    TotalSum = lists:sum(Arr),
    MaxSumOnce = kadane(Arr),

    if K == 1 ->
        pmod(MaxSumOnce, ?MOD);
    true -> % K > 1
        ArrTwice = Arr ++ Arr,
        MaxSumTwice = kadane(ArrTwice),
        if TotalSum < 0 ->
            pmod(MaxSumTwice, ?MOD);
        true -> % TotalSum >= 0
            RemainingK = K - 2,
            AddedSum = RemainingK * TotalSum,
            Result = MaxSumTwice + AddedSum,
            pmod(Result, ?MOD)
        end
    end.