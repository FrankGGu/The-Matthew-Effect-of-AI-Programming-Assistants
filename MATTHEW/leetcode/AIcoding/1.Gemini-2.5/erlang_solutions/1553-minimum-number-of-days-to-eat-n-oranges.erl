-module(solution).
-export([min_days/1]).

-spec min_days(N :: integer()) -> integer().
min_days(N) ->
    {Result, _FinalMemo} = min_days_memo_impl(N, #{}),
    Result.

min_days_memo_impl(0, Memo) -> {0, Memo};
min_days_memo_impl(1, Memo) -> {1, Memo};
min_days_memo_impl(N, Memo) ->
    case maps:find(N, Memo) of
        {ok, Result} ->
            {Result, Memo};
        _ ->
            {Res1_val, Memo1} = min_days_memo_impl(N - 1, Memo),
            Val1 = 1 + Res1_val,

            {Res2_val, Memo2} = min_days_memo_impl(N div 2, Memo1),
            Val2 = (N rem 2) + 1 + Res2_val,

            {Res3_val, Memo3} = min_days_memo_impl(N div 3, Memo2),
            Val3 = (N rem 3) + 1 + Res3_val,

            MinRes = min(Val1, Val2, Val3),
            NewMemo = maps:put(N, MinRes, Memo3),
            {MinRes, NewMemo}
    end.