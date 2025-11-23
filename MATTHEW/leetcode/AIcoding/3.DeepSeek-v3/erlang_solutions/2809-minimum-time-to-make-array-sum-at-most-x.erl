-module(solution).
-export([minimum_time/2]).

minimum_time(Nums1, Nums2) ->
    Pairs = lists:zip(lists:sort(Nums2), Nums1),
    SortedPairs = lists:keysort(1, Pairs),
    {Sum1, Sum2} = lists:foldl(fun({B, A}, {Acc1, Acc2}) -> {Acc1 + A, Acc2 + B} end, {0, 0}, SortedPairs),
    DP = lists:foldl(fun({B, A}, Dp) -> 
                         lists:map(fun({T, S}) -> 
                                      if 
                                          T + 1 =< length(SortedPairs) andalso S + A + (T + 1) * B =< Sum1 + Sum2 * (T + 1) -> 
                                              {T + 1, S + A + (T + 1) * B};
                                          true -> 
                                              {T, S}
                                      end 
                                   end, Dp) 
                      end, [{0, 0}], SortedPairs),
    case lists:filter(fun({T, _}) -> T > 0 end, DP) of
        [] -> -1;
        ValidTs -> {MinT, _} = lists:min(ValidTs), MinT
    end.