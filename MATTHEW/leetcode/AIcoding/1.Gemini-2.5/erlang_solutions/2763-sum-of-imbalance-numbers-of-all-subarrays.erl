-module(solution).
-export([sum_of_imbalance_numbers/1]).

sum_of_imbalance_numbers(Nums) ->
    N = length(Nums),

    if N < 2 ->
        0
    else
        Arr = array:from_list(Nums),
        LogN = floor(math:log2(N)),

        ST_min_tables = array:new(),
        ST_max_tables = array:new(),

        ST_min_k0 = array:from_list(Nums),
        ST_max_k0 = array:from_list(Nums),
        ST_min_acc = array:set(0, ST_min_k0, ST_min_tables),
        ST_max_acc = array:set(0, ST_max_k0, ST_max_tables),

        ST_min_final = lists:foldl(
            fun(K, CurrentST_min) ->
                PrevST_min_k = array:get(K-1, CurrentST_min),
                NewST_min_k_list = [
                    min(array:get(I, PrevST_min_k), array:get(I + (1 bsl (K-1)), PrevST_min_k))
                    || I <- lists:seq(0, N - (1 bsl K))
                ],
                array:set(K, array:from_list(NewST_min_k_list), CurrentST_min)
            end,
            ST_min_acc,
            lists:seq(1, LogN)
        ),

        ST_max_final = lists:foldl(
            fun(K, CurrentST_max) ->
                PrevST_max_k = array:get(K-1, CurrentST_max),
                NewST_max_k_list = [
                    max(array:get(I, PrevST_max_k), array:get(I + (1 bsl (K-1)), PrevST_max_k))
                    || I <- lists:seq(0, N - (1 bsl K))
                ],
                array:set(K, array:from_list(NewST_max_k_list), CurrentST_max)
            end,
            ST_max_acc,
            lists:seq(1, LogN)
        ),

        QueryMin = fun(L, R) ->
            Len = R - L + 1,
            K = floor(math:log2(Len)),
            min(array:get(L, array:get(K, ST_min_final)), array:get(R - (1 bsl K) + 1, array:get(K, ST_min_final)))
        end,

        QueryMax = fun(L, R) ->
            Len = R - L + 1,
            K = floor(math:log2(Len)),
            max(array:get(L, array:get(K, ST_max_final)), array:get(R - (1 bsl K) + 1, array:get(K, ST_max_final)))
        end,

        TotalSum = lists:foldl(
            fun(I, AccSum) ->
                lists:foldl(
                    fun(J, CurrentAccSum) ->
                        ValI = array:get(I, Arr),
                        ValJ = array:get(J, Arr),

                        if ValI < ValJ ->
                            if J == I + 1 ->
                                CurrentAccSum + (I + 1) * (N - J)
                            else ->
                                MinValBetween = QueryMin(I + 1, J - 1),
                                MaxValBetween = QueryMax(I + 1, J - 1),
                                if MinValBetween >= ValJ or MaxValBetween <= ValI ->
                                    CurrentAccSum + (I + 1) * (N - J)
                                else ->
                                    CurrentAccSum
                                end
                            end
                        else ->
                            CurrentAccSum
                        end
                    end,
                    AccSum,
                    lists:seq(I + 1, N - 1)
                )
            end,
            0,
            lists:seq(0, N - 2)
        ),
        TotalSum
    end.