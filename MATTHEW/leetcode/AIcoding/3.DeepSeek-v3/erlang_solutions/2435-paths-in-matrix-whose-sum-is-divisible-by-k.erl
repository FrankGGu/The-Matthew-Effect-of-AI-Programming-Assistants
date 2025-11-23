-module(solution).
-export([number_of_paths/3]).

number_of_paths(Grid, K) ->
    M = length(Grid),
    N = length(hd(Grid)),
    DP = array:new([{size, M}, {default, array:new([{size, N}, {default, array:new([{size, K}, {default, 0}])}])}]),
    FirstVal = lists:nth(1, lists:nth(1, Grid)),
    InitDP = array:set(0, array:set(0, array:set(FirstVal rem K, 1, array:get(0, array:get(0, DP))), array:get(0, DP)), DP),
    FinalDP = lists:foldl(fun(I, AccI) ->
        lists:foldl(fun(J, AccJ) ->
            if
                I =:= 0, J =:= 0 -> AccJ;
                true ->
                    CurrentVal = lists:nth(J + 1, lists:nth(I + 1, Grid)),
                    PrevDP = if
                        I =:= 0 -> array:get(J - 1, array:get(I, AccJ));
                        J =:= 0 -> array:get(J, array:get(I - 1, AccJ));
                        true ->
                            Top = array:get(J, array:get(I - 1, AccJ)),
                            Left = array:get(J - 1, array:get(I, AccJ)),
                            merge_mods(Top, Left, K)
                    end,
                    NewMods = array:map(fun(Mod, Count) ->
                        NewMod = (Mod + CurrentVal) rem K,
                        array:get(NewMod, array:get(J, array:get(I, AccJ))) + Count
                    end, PrevDP),
                    array:set(I, array:set(J, NewMods, array:get(I, AccJ)), AccJ)
            end
        end, AccI, lists:seq(0, N - 1))
    end, InitDP, lists:seq(0, M - 1)),
    array:get(0, array:get(N - 1, array:get(M - 1, FinalDP))).

merge_mods(Top, Left, K) ->
    array:map(fun(Mod, Count) ->
        (array:get(Mod, Top) + array:get(Mod, Left)) rem 1000000007
    end, array:new([{size, K}, {default, 0}])).