-module(solution).
-export([threeSumMulti/2]).

build_freq_array(Arr) ->
    %% Initial array of size 101 (for values 0-100) with all zeros
    Freq = array:new([{size, 101}, {fixed, true}, {default, 0}]),
    lists:foldl(fun(Num, AccFreq) ->
        array:set(Num, array:get(Num, AccFreq) + 1, AccFreq)
    end, Freq, Arr).

threeSumMulti(Arr, Target) ->
    FreqArray = build_freq_array(Arr),
    Mod = 1000000007,
    TotalCount = 0,

    %% Iterate X from 0 to 100
    lists:foldl(fun(X, AccCountX) ->
        CountX = array:get(X, FreqArray),
        if CountX == 0 -> AccCountX;
           true ->
                %% Iterate Y from X to 100 (to ensure X <= Y)
                lists:foldl(fun(Y, AccCountY) ->
                    CountY = array:get(Y, FreqArray),
                    if CountY == 0 -> AccCountY;
                       true ->
                            Z = Target - X - Y,
                            %% Ensure Z is within bounds and Y <= Z
                            if Z < Y or Z > 100 -> AccCountY;
                               true ->
                                    CountZ = array:get(Z, FreqArray),
                                    if CountZ == 0 -> AccCountY;
                                       true ->
                                            NewCombinations = 
                                                if X == Y andalso Y == Z ->
                                                    %% Case 1: X = Y = Z
                                                    (CountX * (CountX - 1) * (CountX - 2)) div 6;
                                                X == Y andalso Y /= Z ->
                                                    %% Case 2: X = Y < Z
                                                    (CountX * (CountX - 1) div 2) * CountZ;
                                                X /= Y andalso Y == Z ->
                                                    %% Case 3: X < Y = Z
                                                    CountX * (CountY * (CountY - 1) div 2);
                                                X < Y andalso Y < Z ->
                                                    %% Case 4: X < Y < Z
                                                    CountX * CountY * CountZ;
                                                true -> 0 %% Should not be reached with correct logic
                                                end,
                                            (AccCountY + NewCombinations) rem Mod
                                    end
                            end
                    end
                end, AccCountX, lists:seq(X, 100))
        end
    end, TotalCount, lists:seq(0, 100)).