-module(fair_pairs).
-export([count_fair_pairs/3]).

count_fair_pairs(Nums, Lower, Upper) ->
    lists:foldl(
        fun(Num1, Acc) ->
            lists:foldl(
                fun(Num2, InnerAcc) ->
                    Sum = Num1 + Num2,
                    case Sum >= Lower andalso Sum <= Upper of
                        true -> InnerAcc + 1;
                        false -> InnerAcc
                    end
                end,
                Acc,
                Nums
            )
        end,
        0,
        Nums
    ) div 2.