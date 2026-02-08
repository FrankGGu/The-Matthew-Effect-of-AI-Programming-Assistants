-spec kth_largest_level_sum(Root :: #tree_node{} | null, K :: integer()) -> integer().
kth_largest_level_sum(Root, K) ->
    case Root of
        null -> -1;
        _ ->
            Sums = level_sums(Root),
            case length(Sums) < K of
                true -> -1;
                false ->
                    Sorted = lists:sort(fun(A, B) -> A > B end, Sums),
                    lists:nth(K, Sorted)
            end
    end.

level_sums(Root) ->
    Q = queue:in(Root, queue:new()),
    level_sums(Q, []).

level_sums(Q, Acc) ->
    case queue:is_empty(Q) of
        true -> lists:reverse(Acc);
        false ->
            {Level, NewQ} = process_level(Q, 0, queue:new()),
            level_sums(NewQ, [Level | Acc])
    end.

process_level(Q, Sum, NewQ) ->
    case queue:out(Q) of
        {empty, _} -> {Sum, NewQ};
        {{value, Node}, RestQ} ->
            NewSum = Sum + Node#tree_node.val,
            NewQ1 = case Node#tree_node.left of
                       null -> NewQ;
                       Left -> queue:in(Left, NewQ)
                   end,
            NewQ2 = case Node#tree_node.right of
                       null -> NewQ1;
                       Right -> queue:in(Right, NewQ1)
                   end,
            process_level(RestQ, NewSum, NewQ2)
    end.