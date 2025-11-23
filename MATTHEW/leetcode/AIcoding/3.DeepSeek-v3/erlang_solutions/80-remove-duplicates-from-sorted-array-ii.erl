-spec remove_duplicates(Nums :: [integer()]) -> integer().
remove_duplicates(Nums) ->
    remove_duplicates(Nums, 0, 0, 0).

remove_duplicates([], _Prev, _Count, Index) ->
    Index;
remove_duplicates([H|T], Prev, Count, Index) ->
    if
        H =:= Prev andalso Count >= 2 ->
            remove_duplicates(T, Prev, Count, Index);
        H =:= Prev ->
            NewNums = setelement(Index + 1, list_to_tuple(Nums), H),
            remove_duplicates(T, Prev, Count + 1, Index + 1);
        true ->
            NewNums = setelement(Index + 1, list_to_tuple(Nums), H),
            remove_duplicates(T, H, 1, Index + 1)
    end.