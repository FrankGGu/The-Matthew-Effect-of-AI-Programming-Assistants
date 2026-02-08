-spec permutation_difference(S :: unicode:unicode_binary(), T :: unicode:unicode_binary()) -> integer().
permutation_difference(S, T) ->
    SList = binary_to_list(S),
    TList = binary_to_list(T),
    IndexMap = lists:foldl(fun(Char, Acc) -> 
        maps:put(Char, length(Acc), Acc ++ [Char] 
    end, [], SList),
    lists:foldl(fun({Char, Index}, Sum) -> 
        Sum + abs(Index - maps:get(Char, IndexMap, 0)) 
    end, 0, lists:zip(TList, lists:seq(0, length(TList) - 1))).