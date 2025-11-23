-spec min_operations(Nums :: [integer()]) -> integer().
min_operations(Nums) ->
    min_operations(Nums, 0, 0).

min_operations([], Flips, Ops) ->
    Ops;
min_operations([1 | Rest], Flips, Ops) when Flips rem 2 == 0 ->
    min_operations(Rest, Flips, Ops);
min_operations([0 | Rest], Flips, Ops) when Flips rem 2 == 0 ->
    min_operations(Rest, Flips + 1, Ops + 1);
min_operations([0 | Rest], Flips, Ops) ->
    min_operations(Rest, Flips, Ops);
min_operations([1 | Rest], Flips, Ops) ->
    min_operations(Rest, Flips + 1, Ops + 1).