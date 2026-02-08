-module(solution).
-export([findKDistantIndices/3]).

findKDistantIndices(Nums, Key, K) ->
    N = length(Nums),
    KeyIndices = [I || {Val, I} <- lists:zip(Nums, lists:seq(0, N - 1)), Val == Key],

    AllJDup = lists:flatmap(fun(I) ->
                                    MinJ = max(0, I - K),
                                    MaxJ = min(N - 1, I + K),
                                    lists:seq(MinJ, MaxJ)
                            end, KeyIndices),

    lists:usort(AllJDup).