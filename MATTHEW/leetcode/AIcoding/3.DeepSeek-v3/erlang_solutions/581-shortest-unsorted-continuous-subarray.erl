-spec find_unsorted_subarray(Nums :: [integer()]) -> integer().
find_unsorted_subarray(Nums) ->
    Sorted = lists:sort(Nums),
    find_start(Nums, Sorted, 0, length(Nums) - 1).

find_start(Nums, Sorted, Start, End) when Start =< End ->
    case lists:nth(Start + 1, Nums) =:= lists:nth(Start + 1, Sorted) of
        true -> find_start(Nums, Sorted, Start + 1, End);
        false -> find_end(Nums, Sorted, Start, End)
    end;
find_start(_, _, _, _) ->
    0.

find_end(Nums, Sorted, Start, End) when End >= Start ->
    case lists:nth(End + 1, Nums) =:= lists:nth(End + 1, Sorted) of
        true -> find_end(Nums, Sorted, Start, End - 1);
        false -> End - Start + 1
    end;
find_end(_, _, _, _) ->
    0.