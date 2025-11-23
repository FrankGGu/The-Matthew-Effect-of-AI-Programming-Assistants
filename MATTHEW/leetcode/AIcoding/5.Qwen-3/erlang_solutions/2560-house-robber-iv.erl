-module(house_robber_iv).
-export([delete_and_earn/1]).

delete_and_earn(Robbed) ->
    Max = lists:max(Robbed),
    Count = array:new(Max + 1, {default, 0}),
    lists:foreach(fun(N) -> array:set(N, array:get(N, Count) + 1, Count) end, Robbed),
    dp(Count, 0, 0).

dp(_, 0, 0) -> 0;
dp(Count, Index, Prev) when Index > array:size(Count) - 1 -> Prev;
dp(Count, Index, Prev) ->
    Current = array:get(Index, Count) * Index,
    Next = Index + 1,
    if
        Index == 0 ->
            dp(Count, Next, Current);
        true ->
            dp(Count, Next, max(Prev, Current + dp(Count, Next, 0)))
    end.