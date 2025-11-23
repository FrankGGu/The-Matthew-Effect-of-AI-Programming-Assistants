-module(minimum_total_space_wasted).
-export([min_wasted_space/2]).

min_wasted_space(Nums, K) ->
    N = length(Nums),
    Memo = dict:new(),

    min_wasted_space_helper(Nums, 0, K, Memo, N).

min_wasted_space_helper(Nums, I, K, Memo, N) when I >= N ->
    0;
min_wasted_space_helper(Nums, I, K, Memo, N) ->
    Key = {I, K},
    case dict:is_key(Key, Memo) of
        true ->
            dict:fetch(Key, Memo);
        false ->
            Result =
                case K of
                    0 ->
                        max_val = lists:max(lists:sublist(Nums, I, N - I)),
                        Waste = lists:sum([max_val - Num || Num <- lists:sublist(Nums, I, N - I)]),
                        Waste;
                    _ ->
                        lists:foldl(
                            fun(J, Acc) ->
                                max_val = lists:max(lists:sublist(Nums, I, J - I + 1)),
                                Waste = lists:sum([max_val - Num || Num <- lists:sublist(Nums, I, J - I + 1)]),
                                min(Acc, Waste + min_wasted_space_helper(Nums, J + 1, K - 1, Memo, N))
                            end,
                            infinity,
                            lists:seq(I, N - 1)
                        )
                end,
            dict:store(Key, Result, Memo),
            Result
    end.

infinity() ->
    16#7fffffff#.