-module(min_days).
-export([min_days/1]).

min_days(N) ->
    min_days(N, #{}, 0).

min_days(0, _, Days) ->
    Days;
min_days(N, Memo, Days) ->
    case maps:get(N, Memo, undefined) of
        undefined ->
            D1 = min_days(N div 2, Memo, Days + 1 + N rem 2),
            D2 = min_days(N div 3, Memo, Days + 1 + N rem 3),
            MinDays = min(D1, D2),
            min_days(N, Memo#{N => MinDays}, Days);
        Val ->
            Val
    end.