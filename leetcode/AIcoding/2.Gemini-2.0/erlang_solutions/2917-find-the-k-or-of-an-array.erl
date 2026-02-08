-module(k_or).
-export([find_k_or/2]).

find_k_or(Nums, K) ->
    find_k_or(Nums, K, 0, 0).

find_k_or([], _, Acc, _) ->
    Acc;
find_k_or(_, 0, Acc, _) ->
    Acc;
find_k_or(Nums, K, Acc, Bit) when Bit >= 31 ->
    Acc;
find_k_or(Nums, K, Acc, Bit) ->
    Count = lists:foldl(fun(Num, C) ->
                                if (Num band (1 bsl Bit)) > 0 then
                                    C + 1
                                else
                                    C
                                end
                            end, 0, Nums),
    NewAcc = if Count >= K then
                 Acc bor (1 bsl Bit)
              else
                 Acc
              end,
    find_k_or(Nums, K, NewAcc, Bit + 1).