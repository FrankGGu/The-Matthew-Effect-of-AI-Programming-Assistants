-module(solution).
-export([gcds/1]).

gcds(Nums) ->
    ActualMaxVal = lists:max(Nums),
    MaxPossibleVal = 200000,

    InitialPresentArray = array:new([{size, MaxPossibleVal + 1}, {fixed, true}]),
    PresentArray = lists:foldl(fun(Num, AccArray) ->
                                   array:set(Num, true, AccArray)
                               end, InitialPresentArray, Nums),

    count_gcds(1, ActualMaxVal, PresentArray, 0).

count_gcds(G, ActualMaxVal, PresentArray, AccCount) when G > ActualMaxVal ->
    AccCount;
count_gcds(G, ActualMaxVal, PresentArray, AccCount) ->
    CurrentGCD = calculate_subsequence_gcd(G, ActualMaxVal, PresentArray, 0, G),
    NewAccCount = if CurrentGCD == G -> AccCount + 1;
                     true -> AccCount
                  end,
    count_gcds(G + 1, ActualMaxVal, PresentArray, NewAccCount).

calculate_subsequence_gcd(Multiple, ActualMaxVal, PresentArray, CurrentGCD, G) when Multiple > ActualMaxVal ->
    CurrentGCD;
calculate_subsequence_gcd(Multiple, ActualMaxVal, PresentArray, CurrentGCD, G) ->
    if CurrentGCD == G ->
        G;
    else
        IsPresent = array:get(Multiple, PresentArray),
        NewCurrentGCD = if IsPresent ->
                            math:gcd(CurrentGCD, Multiple);
                            true ->
                            CurrentGCD
                        end,
        calculate_subsequence_gcd(Multiple + G, ActualMaxVal, PresentArray, NewCurrentGCD, G)
    end.