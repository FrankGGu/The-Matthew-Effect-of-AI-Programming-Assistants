-module(solution).
-export([great_partitions/2]).

great_partitions(Nums, K) ->
    Mod = 1000000007,
    TotalSum = lists:sum(Nums),
    N = length(Nums),

    if TotalSum < 2 * K -> 0;
       true ->
            InitialDpList = [1 | lists:duplicate(TotalSum, 0)],
            InitialDpArray = array:from_list(InitialDpList),

            FinalDpArray = lists:foldl(
                fun(Num, CurrentDpArray) ->
                    lists:foldl(
                        fun(J, AccDpArray) ->
                            Val_J = array:get(J, AccDpArray),
                            Val_J_Minus_Num = array:get(J - Num, AccDpArray),
                            NewVal_J = (Val_J + Val_J_Minus_Num) rem Mod,
                            array:set(J, NewVal_J, AccDpArray)
                        end,
                        CurrentDpArray,
                        lists:seq(TotalSum, Num, -1)
                    )
                end,
                InitialDpArray,
                Nums
            ),

            CountSmall = lists:foldl(
                fun(I, Acc) ->
                    (Acc + array:get(I, FinalDpArray)) rem Mod
                end,
                0,
                lists:seq(0, K - 1)
            ),

            TotalPartitions = (power(2, N, Mod) - 2 + Mod) rem Mod,
            BadPartitions = (2 * (CountSmall - 1 + Mod)) rem Mod,

            (TotalPartitions - BadPartitions + Mod) rem Mod
    end.

power(Base, Exp, Mod) ->
    power(Base, Exp, Mod, 1).

power(_, 0, _, Acc) -> Acc;
power(Base, Exp, Mod, Acc) ->
    if Exp rem 2 == 1 ->
        power((Base * Base) rem Mod, Exp div 2, Mod, (Acc * Base) rem Mod);
    else
        power((Base * Base) rem Mod, Exp div 2, Mod, Acc)
    end.