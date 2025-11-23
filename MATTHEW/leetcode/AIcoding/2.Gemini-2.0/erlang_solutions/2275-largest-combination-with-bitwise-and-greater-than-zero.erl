-module(largest_combination).
-export([largest_combination/1]).

largest_combination(Nums) ->
    largest_combination(Nums, 0, 31).

largest_combination(_Nums, Acc, -1) ->
    Acc;
largest_combination(Nums, Acc, Bit) ->
    Count = lists:foldl(fun(Num, C) ->
                               if (Num band (1 bsl Bit)) > 0 ->
                                   C + 1;
                               otherwise ->
                                   C
                               end
                           end, 0, Nums),
    NewAcc = max(Acc, Count),
    largest_combination(Nums, NewAcc, Bit - 1).