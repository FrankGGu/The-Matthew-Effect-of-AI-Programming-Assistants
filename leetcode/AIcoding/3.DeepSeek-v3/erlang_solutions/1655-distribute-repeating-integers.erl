-module(distribute_repeating_integers).
-export([can_distribute/2]).

can_distribute(Nums, Quantity) ->
    FreqMap = lists:foldl(fun(N, Acc) -> maps:update_with(N, fun(V) -> V + 1 end, 1, Acc) end, #{}, Nums),
    FreqList = lists:sort(fun(A, B) -> A >= B end, maps:values(FreqMap)),
    QuantityList = lists:sort(fun(A, B) -> A >= B end, Quantity),
    can_assign(FreqList, QuantityList).

can_assign([], _) -> true;
can_assign(_, []) -> false;
can_assign([F | Fs], [Q | Qs]) when F =< Q ->
    can_assign(Fs, Qs);
can_assign([F | Fs], [Q | Qs]) when F > Q ->
    can_assign([F - Q | Fs], Qs).