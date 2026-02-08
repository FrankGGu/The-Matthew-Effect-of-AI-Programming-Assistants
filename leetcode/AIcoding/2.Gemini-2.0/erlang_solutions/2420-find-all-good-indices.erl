-module(find_all_good_indices).
-export([find_all_good_indices/1]).

find_all_good_indices(Nums) ->
    N = length(Nums),
    if N < 3 ->
        []
    else
        PrefixDec = lists:foldl(fun(I, Acc) ->
                                     if I < 2 ->
                                         [1 | Acc]
                                     else
                                         if lists:nth(I, Nums) <= lists:nth(I - 1, Nums) ->
                                             [lists:nth(I - 1, Acc) + 1 | Acc]
                                         else
                                             [1 | Acc]
                                         end
                                 end, [], lists:seq(1, N)),
        SuffixInc = lists:foldl(fun(I, Acc) ->
                                     if I > N - 1 ->
                                         [1 | Acc]
                                     else
                                         if lists:nth(I, Nums) <= lists:nth(I + 1, Nums) ->
                                             [lists:nth(I + 1, Acc) + 1 | Acc]
                                         else
                                             [1 | Acc]
                                         end
                                 end, [], lists:seq(N, 1, -1)),

        GoodIndices = lists:foldl(fun(I, Acc) ->
                                       if lists:nth(I - 1, PrefixDec) >= I - 1 and
                                          lists:nth(N - I + 2, SuffixInc) >= I - 1 ->
                                           [I | Acc]
                                       else
                                           Acc
                                       end
                                   end, [], lists:seq(2, N - 1)),
        lists:reverse(GoodIndices)
    end.