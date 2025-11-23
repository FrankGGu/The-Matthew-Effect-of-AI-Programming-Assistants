-spec min_operations(Nums :: [integer()]) -> integer().
min_operations(Nums) ->
    min_operations(Nums, 0, 0).

min_operations([], _, Ops) -> Ops;
min_operations([_], _, Ops) -> Ops;
min_operations([A, B | Rest], Prev, Ops) when A < B ->
    min_operations([B | Rest], A, Ops);
min_operations([A, B | Rest], Prev, Ops) ->
    case Prev < B of
        true -> min_operations([B | Rest], A, Ops + 1);
        false -> min_operations([A | Rest], Prev, Ops + 1)
    end.