-module(combination_sum_iv).
-export([combination_sum_iv/2]).

combination_sum_iv(Nums, Target) ->
    memo(Nums, Target, #{0 => 1}).

memo(Nums, 0, Memo) ->
    maps:get(0, Memo, 0);
memo(Nums, Target, Memo) when Target < 0 ->
    0;
memo(Nums, Target, Memo) ->
    case maps:is_key(Target, Memo) of
        true ->
            maps:get(Target, Memo);
        false ->
            Result = lists:foldl(
                fun(Num, Acc) ->
                    Acc + memo(Nums, Target - Num, Memo)
                end,
                0,
                Nums
            ),
            NewMemo = maps:put(Target, Result, Memo),
            Result
    end.