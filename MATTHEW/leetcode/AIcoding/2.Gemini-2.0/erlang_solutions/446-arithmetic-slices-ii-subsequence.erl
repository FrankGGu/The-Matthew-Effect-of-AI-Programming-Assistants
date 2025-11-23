-module(arithmetic_slices_ii_subsequence).
-export([number_of_arithmetic_slices/1]).

number_of_arithmetic_slices(Nums) ->
    N = length(Nums),
    number_of_arithmetic_slices(Nums, N).

number_of_arithmetic_slices(Nums, N) ->
    Memos = lists:map(fun(_) -> dict:new() end, lists:seq(1, N)),
    number_of_arithmetic_slices_helper(Nums, 0, N, Memos).

number_of_arithmetic_slices_helper(Nums, Acc, N, Memos) ->
    lists:foldl(fun(I, Acc1) ->
                        lists:foldl(fun(J, Acc2) ->
                                        if I < J ->
                                            Diff = lists:nth(J, Nums) - lists:nth(I, Nums),
                                            Acc3 = update_memo(Nums, I, Diff, J, N, Memos),
                                            Acc2 + Acc3
                                        else
                                            Acc2
                                        end
                                    end, Acc1, lists:seq(1, N))
                end, 0, lists:seq(1, N)).

update_memo(Nums, I, Diff, J, N, Memos) ->
    PrevCount = get_count(Memos, I, Diff),
    dict:update(Diff, fun(X) -> X + 1 end, 1, lists:nth(J, Memos)),
    PrevCount.

get_count(Memos, I, Diff) ->
    Dict = lists:nth(I, Memos),
    case dict:find(Diff, Dict) of
        {ok, Count} -> Count;
        error -> 0
    end.