-spec count_happy_students(Nums :: [integer()]) -> integer().
count_happy_students(Nums) ->
    Sorted = lists:sort(Nums),
    count_happy(Sorted, 0, 0).

count_happy([], Count, _) ->
    Count;
count_happy([H | T], Count, Index) ->
    case (Index + 1 =< H) andalso (Index + 1 >= (if T == [] -> 0; true -> hd(T) end)) of
        true -> count_happy(T, Count + 1, Index + 1);
        false -> count_happy(T, Count, Index + 1)
    end.