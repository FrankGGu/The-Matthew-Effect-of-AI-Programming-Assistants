-spec search_insert(Nums :: [integer()], Target :: integer()) -> integer().
search_insert(Nums, Target) ->
    search_insert(Nums, Target, 0).

search_insert([], Target, Index) -> Index;
search_insert([H | T], Target, Index) when H >= Target -> Index;
search_insert([_ | T], Target, Index) -> search_insert(T, Target, Index + 1).
