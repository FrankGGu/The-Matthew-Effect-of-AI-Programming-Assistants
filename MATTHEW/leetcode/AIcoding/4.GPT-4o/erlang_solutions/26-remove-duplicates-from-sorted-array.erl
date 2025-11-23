-spec remove_duplicates(Nums :: list(integer())) -> integer().
remove_duplicates(Nums) ->
    remove_duplicates(Nums, 0, []).

remove_duplicates([], Count, Unique) -> Count;
remove_duplicates([Head | Tail], Count, []) -> 
    remove_duplicates(Tail, Count + 1, [Head]);
remove_duplicates([Head | Tail], Count, [Last | _]) when Head =:= Last -> 
    remove_duplicates(Tail, Count, [Last]);
remove_duplicates([Head | Tail], Count, Unique) -> 
    remove_duplicates(Tail, Count + 1, [Head | Unique]).
