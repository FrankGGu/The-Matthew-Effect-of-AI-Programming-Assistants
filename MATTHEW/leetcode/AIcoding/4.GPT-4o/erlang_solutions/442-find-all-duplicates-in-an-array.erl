-spec find_duplicates([integer()]) -> [integer()].
find_duplicates(Nums) ->
    find_duplicates(Nums, [], []).

-spec find_duplicates([integer()], [integer()], [integer()]) -> [integer()].
find_duplicates([], _Visited, Dups) ->
    lists:reverse(Dups);
find_duplicates([H | T], Visited, Dups) ->
    case lists:member(H, Visited) of
        true -> find_duplicates(T, Visited, [H | Dups]);
        false -> find_duplicates(T, [H | Visited], Dups)
    end.
