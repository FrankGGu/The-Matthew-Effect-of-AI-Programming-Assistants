-module(solution).
-export([num_roll_to_target/3]).

num_roll_to_target(D, F, Target) ->
    memo(D, F, Target, []).

memo(0, _F, Target, Memo) ->
    case Target == 0 of
        true ->
            {1, Memo};
        false ->
            {0, Memo}
    end;
memo(D, F, Target, Memo) ->
    case lists:keyfind({D, Target}, 1, Memo) of
        {_, Value} ->
            {Value, Memo};
        false ->
            {Result, NewMemo} = calculate(D, F, Target, Memo),
            {Result, [{D, Target, Result} | NewMemo]}
    end.

calculate(D, F, Target, Memo) ->
    Result = lists:foldl(
        fun(Face, Acc) ->
            if Target - Face >= 0 then
                {Value, NewMemo} = memo(D - 1, F, Target - Face, Memo),
                Acc + Value
            else
                Acc
            end
        end,
        0,
        lists:seq(1, F)
    ) rem 1000000007,
    {Result, Memo}.