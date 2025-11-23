-module(merge_stones).
-export([mergeStones/1]).

mergeStones(Stones) ->
    N = length(Stones),
    Sum = lists:sum(Stones),
    DP = array:new([{size, N}, {default, 0}]),
    DP2 = array:new([{size, N}, {default, 0}]),
    mergeStones(Stones, 0, N-1, 1, DP, DP2, Sum).

mergeStones(_, L, R, K, DP, DP2, _) when L == R ->
    array:get(L, DP);

mergeStones(Stones, L, R, K, DP, DP2, Sum) ->
    case array:get(L, DP) of
        Val when Val /= 0 ->
            Val;
        _ ->
            if
                R - L + 1 < K ->
                    0;
                true ->
                    Min = mergeStonesHelper(Stones, L, R, K, DP, DP2, Sum),
                    array:set(L, Min, DP)
            end
    end.

mergeStonesHelper(Stones, L, R, K, DP, DP2, Sum) ->
    case array:get(L, DP2) of
        Val when Val /= 0 ->
            Val;
        _ ->
            Res = if
                      R - L + 1 == K ->
                          Sum - lists:sum(lists:sublist(Stones, L+1, R-L));
                      true ->
                          Min = lists:foldl(fun I -> fun(I, Acc) ->
                                                      Cost = mergeStones(Stones, L, I, K, DP, DP2, Sum) +
                                                             mergeStones(Stones, I+1, R, K, DP, DP2, Sum),
                                                      if Cost < Acc -> Cost; true -> Acc end
                                                  end, infinity, lists:seq(L, R-1)),
                          if
                              Min == infinity -> 0;
                              true -> Min
                          end
                  end,
            array:set(L, Res, DP2),
            Res
    end.