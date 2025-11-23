-spec count_substrings(S :: unicode:unicode_binary(), C :: char()) -> integer().
count_substrings(S, C) ->
    SList = binary_to_list(S),
    Indices = lists:filtermap(fun({Char, Index}) when Char =:= C -> {true, Index}; (_) -> false end, 
                             lists:zip(SList, lists:seq(0, length(SList) - 1))),
    Count = length(Indices),
    Count * (Count + 1) div 2.