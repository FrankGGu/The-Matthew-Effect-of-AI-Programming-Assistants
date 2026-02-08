-module(solution).
-export([maximumProduct/2]).

-define(MOD, 1000000007).

maximumProduct(Nums, K) ->
    FreqMap = lists:foldl(
        fun(Num, AccMap) ->
            gb_trees:insert(Num, gb_trees:get(Num, AccMap, 0) + 1, AccMap)
        end,
        gb_trees:empty(),
        Nums
    ),

    FinalFreqMap = increment_k_times(FreqMap, K),

    calculate_product(FinalFreqMap, 1).

increment_k_times(FreqMap, 0) -> FreqMap;
increment_k_times(FreqMap, K) ->
    {MinNum, MinCount} = gb_trees:smallest(FreqMap),

    NewFreqMap1 = 
        if
            MinCount > 1 ->
                gb_trees:update(MinNum, MinCount - 1, FreqMap);
            true ->
                gb_trees:delete(MinNum, FreqMap)
        end,

    NewFreqMap2 = gb_trees:insert(MinNum + 1, gb_trees:get(MinNum + 1, NewFreqMap1, 0) + 1, NewFreqMap1),

    increment_k_times(NewFreqMap2, K - 1).

calculate_product(FreqMap, AccProduct) ->
    case gb_trees:is_empty(FreqMap) of
        true -> AccProduct;
        false ->
            {Num, Count} = gb_trees:smallest(FreqMap),

            ProductPart = power_mod(Num, Count, ?MOD),
            NewAccProduct = (AccProduct * ProductPart) rem ?MOD,

            calculate_product(gb_trees:delete(Num, FreqMap), NewAccProduct)
    end.

power_mod(_, 0, _) -> 1;
power_mod(Base, Exp, Mod) ->
    power_mod_acc(Base, Exp, Mod, 1).

power_mod_acc(_, 0, _, Acc) -> Acc;
power_mod_acc(Base, Exp, Mod, Acc) ->
    NewAcc = if (Exp band 1) == 1 -> (Acc * Base) rem Mod; true -> Acc end,
    NewBase = (Base * Base) rem Mod,
    power_mod_acc(NewBase, Exp bsr 1, Mod, NewAcc).