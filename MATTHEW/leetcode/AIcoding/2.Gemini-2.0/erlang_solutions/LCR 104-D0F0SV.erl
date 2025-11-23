-module(combination_sum_iv).
-export([combinationSum4/2]).

combinationSum4(Nums, Target) ->
    memo(Nums, Target, {}).

memo(Nums, 0, Memo) ->
    1;
memo(Nums, Target, Memo) when Target < 0 ->
    0;
memo(Nums, Target, Memo) ->
    case maps:get(Target, Memo, undefined) of
        undefined ->
            Result = lists:foldl(
                fun(Num, Acc) ->
                    Acc + memo(Nums, Target - Num, Memo)
                end,
                0,
                Nums
            ),
            NewMemo = maps:put(Target, Result, Memo),
            Result;
        Value ->
            Value
    end.