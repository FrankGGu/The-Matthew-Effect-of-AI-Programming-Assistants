-spec find_duplicate(Nums :: [integer()]) -> integer().
find_duplicate(Nums) ->
    find_duplicate(Nums, []).

find_duplicate([], _) -> 
    0;  % or error handling
find_duplicate([Head | Tail], Seen) when lists:member(Head, Seen) ->
    Head;
find_duplicate([Head | Tail], Seen) ->
    find_duplicate(Tail, [Head | Seen]).
