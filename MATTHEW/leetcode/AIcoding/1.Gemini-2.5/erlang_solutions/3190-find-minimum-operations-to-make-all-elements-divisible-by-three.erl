-module(solution).
-export([minimum_operations/1]).

minimum_operations(Nums) ->
    lists:foldl(fun(Num, Acc) ->
                    Remainder = Num rem 3,
                    Ops = case Remainder of
                              0 -> 0;
                              1 -> 1;
                              2 -> 1
                          end,
                    Acc + Ops
                end, 0, Nums).