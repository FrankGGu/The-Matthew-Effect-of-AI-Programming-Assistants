-spec min_operations(Nums :: [integer()], Queries :: [integer()]) -> [integer()].
min_operations(Nums, Queries) ->
    Sorted = lists:sort(Nums),
    Prefix = prefix_sum(Sorted),
    lists:map(fun(Q) -> calculate_operations(Sorted, Prefix, Q) end, Queries).

prefix_sum(List) ->
    prefix_sum(List, 0, []).

prefix_sum([], _, Acc) ->
    lists:reverse(Acc);
prefix_sum([H | T], Sum, Acc) ->
    NewSum = Sum + H,
    prefix_sum(T, NewSum, [NewSum | Acc]).

calculate_operations(Sorted, Prefix, Q) ->
    N = length(Sorted),
    case lists:search(fun(X) -> X >= Q end, Sorted) of
        {pos, K} ->
            LeftSum = if K > 0 -> lists:nth(K, Prefix); true -> 0 end,
            RightSum = lists:last(Prefix) - LeftSum,
            (Q * K - LeftSum) + (RightSum - Q * (N - K));
        false ->
            Q * N - lists:last(Prefix)
    end.