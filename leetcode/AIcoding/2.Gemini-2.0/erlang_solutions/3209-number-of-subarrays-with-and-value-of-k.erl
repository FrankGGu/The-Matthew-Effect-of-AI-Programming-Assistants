-module(number_of_subarrays_with_and_value_k).
-export([numSubarraysWithAndValueK/2]).

numSubarraysWithAndValueK(Nums, K) ->
    numSubarraysWithAndValueK(Nums, K, 0, 0, 0).

numSubarraysWithAndValueK([], _, Acc, _, _) ->
    Acc;
numSubarraysWithAndValueK([H|T], K, Acc, CurrentAnd, CurrentLen) ->
    NewAnd = H band CurrentAnd,
    case NewAnd of
        K ->
            numSubarraysWithAndValueK(T, K, Acc + CurrentLen + 1, NewAnd, CurrentLen + 1);
        _ when NewAnd < K ->
            numSubarraysWithAndValueK(T, K, Acc, 0, 0);
        _ ->
            Acc1 = countAndEqualToK(K, H, T, 0),
            numSubarraysWithAndValueK(T, K, Acc + Acc1, 0, 0)
    end.

countAndEqualToK(K, H, T, Acc) ->
    countAndEqualToK(K, H, T, Acc, H).

countAndEqualToK(_, _, [], Acc, _) ->
    Acc;
countAndEqualToK(K, H, [H2|T], Acc, CurrentAnd) ->
    NewAnd = H2 band CurrentAnd,
    case NewAnd of
        K ->
            countAndEqualToK(K, H, T, Acc + 1, NewAnd);
        _ when NewAnd < K ->
            Acc;
        _ ->
            countAndEqualToK(K, H, T, Acc, NewAnd)
    end.