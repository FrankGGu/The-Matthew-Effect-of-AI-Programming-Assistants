%% -record(list_node, {val = 0 :: integer(), next = null :: 'null' | #list_node{}}).

-spec remove_element(Nums :: [integer()], Val :: integer()) -> integer().
remove_element(Nums, Val) -> 
    remove_element(Nums, Val, 0).

remove_element([], _, Count) -> Count;
remove_element([Head | Tail], Val, Count) when Head =:= Val ->
    remove_element(Tail, Val, Count);
remove_element([Head | Tail], Val, Count) ->
    NewCount = Count + 1,
    remove_element(Tail, Val, NewCount).
