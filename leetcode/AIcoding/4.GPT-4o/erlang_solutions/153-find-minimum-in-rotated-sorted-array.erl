%% -spec find_min(Nums :: [integer()]) -> integer().
find_min([Min]) -> Min;
find_min([H | T]) when H < hd(T) -> H;
find_min([H | T]) -> find_min(T).
