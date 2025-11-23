%% -spec remove_duplicates_from_sorted_array(Nums :: [integer()]) -> integer().
remove_duplicates_from_sorted_array(Nums) ->
    remove_duplicates_from_sorted_array(Nums, 0, -1).

remove_duplicates_from_sorted_array([], Count, _) -> Count;
remove_duplicates_from_sorted_array([Head | Tail], Count, Prev) ->
    remove_duplicates_from_sorted_array(Tail, NewCount, Head) when Count < 2 -> 
        [Head | remove_duplicates_from_sorted_array(Tail, Count + 1, Head)];
    remove_duplicates_from_sorted_array([Head | Tail], Count, Prev) ->
        if 
            Head =:= Prev -> 
                remove_duplicates_from_sorted_array(Tail, Count, Head);
            true -> 
                [Head | remove_duplicates_from_sorted_array(Tail, 1, Head)]
        end.
