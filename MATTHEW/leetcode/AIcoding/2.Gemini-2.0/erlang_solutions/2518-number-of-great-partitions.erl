-module(number_of_great_partitions).
-export([number_of_great_partitions/2]).

number_of_great_partitions(Nums, K) ->
    Sum = lists:sum(Nums),
    if Sum < 2 * K then
        0
    else
        Len = length(Nums),
        Mod = 1000000007,
        DP = lists:duplicate(K, 0) ++ [1],
        lists:foreach(fun(Num) ->
                          lists:foldl(fun(Index, Acc) ->
                                          if Index >= Num then
                                              lists:nthtail(Index - Num, DP) ! (lists:nth(Index - Num + 1, DP) + lists:nth(Index + 1, DP)) rem Mod,
                                              Acc
                                          else
                                              Acc
                                          end
                                      end,
                                      DP,
                                      lists:seq(K, -1, Num))
                      end,
                      Nums),
        TotalSubsets = power(2, Len, Mod),
        InvalidSubsets = (lists:nth(K + 1, DP) * 2) rem Mod,
        (TotalSubsets - InvalidSubsets + Mod) rem Mod
    end.

power(Base, Exp, Mod) ->
    power_helper(Base, Exp, 1, Mod).

power_helper(Base, 0, Acc, _) ->
    Acc;
power_helper(Base, Exp, Acc, Mod) ->
    if Exp rem 2 == 0 then
        power_helper((Base * Base) rem Mod, Exp div 2, Acc, Mod)
    else
        power_helper(Base, Exp - 1, (Acc * Base) rem Mod, Mod)
    end.