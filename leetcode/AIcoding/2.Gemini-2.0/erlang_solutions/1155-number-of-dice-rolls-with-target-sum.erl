-module(dice_rolls).
-export([num_rolls_to_target/3]).

num_rolls_to_target(D, F, Target) ->
    memo(D, F, Target, {}).

memo(0, _, 0, _) -> 1;
memo(0, _, _, _) -> 0;
memo(D, F, Target, Memo) when Target =< 0 -> 0;
memo(D, F, Target, Memo) ->
    case maps:get({D, Target}, Memo, undefined) of
        undefined ->
            Result = solve(D, F, Target, Memo),
            maps:put({D, Target}, Result, Memo);
        Result ->
            Result
    end.

solve(D, F, Target, Memo) ->
    Sum = lists:foldl(fun(Face, Acc) ->
                              NewTarget = Target - Face,
                              Acc + memo(D - 1, F, NewTarget, Memo) rem 16#1000000007
                      end,
                      0,
                      lists:seq(1, F)) rem 16#1000000007.
    Sum.