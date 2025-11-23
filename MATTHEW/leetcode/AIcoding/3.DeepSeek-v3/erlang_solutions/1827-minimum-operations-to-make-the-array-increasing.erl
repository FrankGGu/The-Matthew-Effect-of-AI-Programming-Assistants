-spec min_operations(Nums :: [integer()]) -> integer().
min_operations(Nums) ->
    min_operations(Nums, 0, 0).

min_operations([], _Prev, Ops) -> Ops;
min_operations([H | T], Prev, Ops) when H > Prev ->
    min_operations(T, H, Ops);
min_operations([H | T], Prev, Ops) ->
    Needed = Prev + 1,
    min_operations(T, Needed, Ops + (Needed - H)).