-module(solution).
-export([num_of_pairs/2]).

-spec num_of_pairs(Nums :: [string()], Target :: string()) -> integer().
num_of_pairs(Nums, Target) ->
    IndexedNums = lists:zip(lists:seq(0, length(Nums) - 1), Nums),

    lists:foldl(fun({IndexI, NumI}, Acc1) ->
                    lists:foldl(fun({IndexJ, NumJ}, Acc2) ->
                                    if
                                        IndexI /= IndexJ andalso (NumI ++ NumJ) == Target -> Acc2 + 1;
                                        true -> Acc2
                                    end
                                end, Acc1, IndexedNums)
                end, 0, IndexedNums).