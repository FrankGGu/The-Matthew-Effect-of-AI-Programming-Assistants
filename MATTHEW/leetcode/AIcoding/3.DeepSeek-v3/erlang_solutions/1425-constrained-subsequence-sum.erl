-spec constrained_subset_sum(Nums :: [integer()], K :: integer()) -> integer().
constrained_subset_sum(Nums, K) ->
    {_, _, Res} = lists:foldl(fun(Num, {Q, DP, Max}) ->
        Prev = case queue:is_empty(Q) of
            true -> 0;
            false -> queue:get(Q)
        end,
        Curr = max(Num, Num + Prev),
        DP1 = queue:in(Curr, DP),
        Q1 = clean_queue(Q, Curr),
        Q2 = queue:in(Curr, Q1),
        DP2 = case queue:len(DP1) > K of
            true ->
                {value, Old} = queue:out(DP1),
                Old;
            false ->
                DP1
        end,
        {Q2, DP2, max(Max, Curr)}
    end, {queue:new(), queue:new(), hd(Nums)}, tl(Nums)),
    Res.

clean_queue(Q, Val) ->
    case queue:is_empty(Q) of
        true -> Q;
        false ->
            case queue:get(Q) < Val of
                true -> clean_queue(queue:drop(Q), Val);
                false -> Q
            end
    end.