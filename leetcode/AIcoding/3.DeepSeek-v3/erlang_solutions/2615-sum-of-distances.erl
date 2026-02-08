-spec distance_sum(Nums :: [integer()]) -> [integer()].
distance_sum(Nums) ->
    Sorted = lists:sort(Nums),
    N = length(Sorted),
    Prefix = prefix_sum(Sorted),
    Suffix = suffix_sum(Sorted),
    Result = lists:zipwith3(fun(X, P, S) -> P + S - X * (N - 1) end, Sorted, Prefix, Suffix),
    Map = maps:from_list(lists:zip(Sorted, Result)),
    [maps:get(X, Map) || X <- Nums].

prefix_sum(List) ->
    lists:foldl(fun(X, {Sum, Acc}) -> 
        NewSum = Sum + X,
        {NewSum, [NewSum | Acc]}
    end, {0, []}, tl(List)),
    {Sum, RevAcc} = lists:foldl(fun(X, {Sum, Acc}) -> 
        NewSum = Sum + X,
        {NewSum, [NewSum | Acc]}
    end, {0, []}, tl(List)),
    lists:reverse([0 | RevAcc]).

suffix_sum(List) ->
    {Sum, RevAcc} = lists:foldr(fun(X, {Sum, Acc}) -> 
        NewSum = Sum + X,
        {NewSum, [NewSum | Acc]}
    end, {0, []}, tl(lists:reverse(List))),
    lists:reverse([0 | RevAcc]).