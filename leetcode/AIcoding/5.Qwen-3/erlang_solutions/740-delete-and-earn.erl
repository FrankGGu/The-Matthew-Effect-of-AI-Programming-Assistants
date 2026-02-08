-module(delete_and_earn).
-export([delete_and_earn/1]).

delete_and_earn(Nums) ->
    Count = lists:foldl(fun(N, Acc) -> maps:update(N, 1 + maps:get(N, Acc, 0), Acc) end, #{}, Nums),
    Sorted = lists:sort(maps:keys(Count)),
    Max = lists:last(Sorted),
    dp(Max, Sorted, Count, 0, 0).

dp(_, [], _, Prev, Current) ->
    max(Prev, Current);
dp(N, [N | Rest], Count, Prev, Current) ->
    Value = N * maps:get(N, Count),
    dp(N + 1, Rest, Count, Current, max(Prev + Value, Current));
dp(N, [M | Rest], Count, Prev, Current) when M > N + 1 ->
    dp(M, Rest, Count, Current, Current);
dp(N, [M | Rest], Count, Prev, Current) ->
    dp(M, Rest, Count, Current, max(Prev, Current)).