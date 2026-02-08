-spec min_operations(K :: integer()) -> integer().
min_operations(K) ->
    if
        K == 1 -> 0;
        true -> min_operations_helper(1, 0, K)
    end.

min_operations_helper(Sum, Ops, K) when Sum >= K ->
    Ops;
min_operations_helper(Sum, Ops, K) ->
    case Sum + Sum >= Sum + 1 of
        true -> min_operations_helper(Sum + Sum, Ops + 1, K);
        false -> min_operations_helper(Sum + 1, Ops + 1, K)
    end.