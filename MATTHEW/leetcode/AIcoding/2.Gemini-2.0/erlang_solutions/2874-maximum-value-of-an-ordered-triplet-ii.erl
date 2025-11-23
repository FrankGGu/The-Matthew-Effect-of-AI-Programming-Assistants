-module(maximum_triplet_value_ii).
-export([maximum_triplet_value/1]).

maximum_triplet_value(Nums) ->
    maximum_triplet_value(Nums, 0, 0, 0, 0).

maximum_triplet_value([], MaxResult, _, _, _) ->
    MaxResult;
maximum_triplet_value([Num | Rest], MaxResult, MaxI, MaxIJ, I) ->
    NewMaxIJ = max(MaxIJ, MaxI - Num),
    NewMaxResult = max(MaxResult, MaxIJ * Num),
    NewMaxI = max(MaxI, Num),
    maximum_triplet_value(Rest, NewMaxResult, NewMaxI, NewMaxIJ, I + 1).