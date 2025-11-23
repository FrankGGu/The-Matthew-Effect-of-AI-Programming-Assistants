-module(solution).
-export([max_kelements/2]).

max_kelements(Nums, K) ->
    PriorityQueue = lists:foldl(fun(N, Q) -> insert(Q, N) end, [], Nums),
    {Result, _} = apply_k_operations(PriorityQueue, K, 0),
    Result.

apply_k_operations(Q, 0, Sum) -> {Sum, Q};
apply_k_operations(Q, K, Sum) ->
    {Max, NewQ} = extract_max(Q),
    NewSum = Sum + Max,
    NewMax = ceil(Max / 3),
    UpdatedQ = insert(NewQ, NewMax),
    apply_k_operations(UpdatedQ, K - 1, NewSum).

insert([], N) -> [N];
insert([H | T], N) when N > H -> [N, H | T];
insert([H | T], N) -> [H | insert(T, N)].

extract_max([H | T]) -> {H, T}.

ceil(N) ->
    case N rem 1 of
        0 -> trunc(N);
        _ -> trunc(N) + 1
    end.