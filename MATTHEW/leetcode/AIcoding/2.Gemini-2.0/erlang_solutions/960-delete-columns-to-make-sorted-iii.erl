-module(delete_columns_to_make_sorted_iii).
-export([min_deletion_size/1]).

min_deletion_size(strs) ->
    N = length(hd(strs)),
    L = length(strs),
    Len = length(strs),
    DP = array:new(N, {default, 1}),
    lists:foldl(
        fun(J, Acc) ->
            MaxLen = lists:foldl(
                fun(I, Max) ->
                    if
                        I < J ->
                            Valid = lists:all(
                                fun(K) ->
                                    string:at(lists:nth(K+1, strs), I+1) =< string:at(lists:nth(K+1, strs), J+1)
                                end,
                                lists:seq(0, Len-1)
                            ),
                            if
                                Valid ->
                                    max(Max, array:get(I, Acc) + 1)
                                else
                                    Max
                            end;
                        true ->
                            Max
                    end
                end,
                1,
                lists:seq(0, J-1)
            ),
            array:set(J, MaxLen, Acc)
        end,
        DP,
        lists:seq(0, N-1)
    ),
    MaxLen = lists:foldl(
        fun(I, Max) ->
            max(Max, array:get(I, DP))
        end,
        1,
        lists:seq(0, N-1)
    ),
    N - MaxLen.