-spec min_pair_removal(Nums :: [integer()]) -> integer().
min_pair_removal(Nums) ->
    min_pair_removal(Nums, 0, 0).

min_pair_removal([], Count, _) -> Count;
min_pair_removal([_], Count, _) -> Count;
min_pair_removal([X, Y | Rest], Count, Prev) when X =< Y ->
    min_pair_removal([Y | Rest], Count, X);
min_pair_removal([_X, Y | Rest], Count, _Prev) ->
    min_pair_removal([Y | Rest], Count + 1, Y).