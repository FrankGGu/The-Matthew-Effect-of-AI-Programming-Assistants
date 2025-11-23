-module(min_days).
-export([min_days/1]).

min_days(N) ->
    memo = maps:new(),
    {Ans, _} = dp(N, memo),
    Ans.

dp(1, Memo) -> {1, Memo};
dp(2, Memo) -> {2, Memo};
dp(3, Memo) -> {2, Memo};
dp(N, Memo) ->
    case maps:get(N, Memo, undefined) of
        undefined ->
            A = N rem 2,
            B = N rem 3,
            {D1, Memo1} = dp((N - A) div 2, Memo),
            {D2, Memo2} = dp((N - B) div 3, Memo1),
            Ans = 1 + min(D1 + A, D2 + B),
            {Ans, maps:put(N, Ans, Memo2)};
        Ans ->
            {Ans, Memo}
    end.