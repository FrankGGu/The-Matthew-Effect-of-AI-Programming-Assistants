-spec distinct_difference_array(Nums :: [integer()]) -> [integer()].
distinct_difference_array(Nums) ->
    Prefix = lists:foldl(fun(X, {Acc, Set}) ->
        NewSet = sets:add_element(X, Set),
        {[sets:size(NewSet) | Acc], NewSet}
    end, {[], sets:new()}, Nums),
    PrefixList = lists:reverse(element(1, Prefix)),

    Suffix = lists:foldr(fun(X, {Acc, Set}) ->
        NewSet = sets:add_element(X, Set),
        {[sets:size(NewSet) | Acc], NewSet}
    end, {[], sets:new()}, Nums),
    SuffixList = element(1, Suffix),

    lists:zipwith(fun(P, S) -> P - S end, PrefixList, SuffixList).