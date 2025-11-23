-spec find_shortest_subarray(Nums :: [integer()]) -> integer().
find_shortest_subarray(Nums) ->
    Count = maps:new(),
    First = maps:new(),
    Last = maps:new(),
    MaxDegree = 0,
    {MaxDegree, _, _} = lists:foldl(fun(X, {Degree, Cnt, Frst}) ->
        NewCnt = case maps:is_key(X, Cnt) of
            true -> maps:update_with(X, fun(V) -> V + 1 end, Cnt);
            false -> maps:put(X, 1, Cnt)
        end,
        NewFrst = case maps:is_key(X, Frst) of
            false -> maps:put(X, 1, Frst);
            true -> Frst
        end,
        NewDegree = max(Degree, maps:get(X, NewCnt)),
        {NewDegree, NewCnt, NewFrst}
    end, {MaxDegree, Count, First}, Nums),
    lists:foldl(fun(X, {Degree, Cnt, Frst, Lst}) ->
        NewLst = maps:put(X, 1, Lst),
        {Degree, Cnt, Frst, NewLst}
    end, {MaxDegree, Count, First, Last}, lists:reverse(Nums)),
    Candidates = maps:filter(fun(K, V) -> V == MaxDegree end, Count),
    MinLen = lists:min(lists:map(fun(K) ->
        maps:get(K, Last) - maps:get(K, First) + 1
    end, maps:keys(Candidates))),
    MinLen.