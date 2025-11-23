-spec find_min(Nums :: [integer()]) -> integer().
find_min([Num]) -> Num;
find_min([Head | Tail]) when is_list(Tail) -> 
    find_min(Tail, Head).

find_min([], Min) -> Min;
find_min([Head | Tail], Min) when Head < Min -> 
    find_min(Tail, Head);
find_min([_ | Tail], Min) -> 
    find_min(Tail, Min).
