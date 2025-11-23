-module(solution).
-export([unequal_triplets/1]).

unequal_triplets(Nums) ->
    count_triplets_recursive(Nums, 0).

count_triplets_recursive(Nums, Acc) ->
    case Nums of
        [] -> Acc;
        [_] -> Acc;
        [_,_] -> Acc;
        [Ni | RestI] ->
            AccJ = count_j_recursive(RestI, Ni, Acc),
            count_triplets_recursive(RestI, AccJ)
    end.

count_j_recursive(RestI, Ni, Acc) ->
    case RestI of
        [] -> Acc;
        [_] -> Acc;
        [Nj | RestJ] ->
            AccK = count_k_recursive(RestJ, Ni, Nj, Acc),
            count_j_recursive(RestJ, Ni, AccK)
    end.

count_k_recursive(RestJ, Ni, Nj, Acc) ->
    case RestJ of
        [] -> Acc;
        [Nk | RestK] ->
            NewAcc = if
                Ni =/= Nj andalso Ni =/= Nk andalso Nj =/= Nk ->
                    Acc + 1;
                true ->
                    Acc
            end,
            count_k_recursive(RestK, Ni, Nj, NewAcc)
    end.