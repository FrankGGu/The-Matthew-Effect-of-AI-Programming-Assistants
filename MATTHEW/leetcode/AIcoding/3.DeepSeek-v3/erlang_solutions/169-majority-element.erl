-spec majority_element(Nums :: [integer()]) -> integer().
majority_element(Nums) ->
    Counts = lists:foldl(fun(N, Acc) -> maps:update_with(N, fun(V) -> V + 1 end, 1, Acc) end, #{}, Nums),
    {Element, _} = maps:fold(fun(K, V, {EK, EV}) -> if V > EV -> {K, V}; true -> {EK, EV} end end, {0, 0}, Counts),
    Element.