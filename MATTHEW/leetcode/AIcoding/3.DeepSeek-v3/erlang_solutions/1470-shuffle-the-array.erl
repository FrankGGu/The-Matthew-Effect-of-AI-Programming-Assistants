-spec shuffle(Nums :: [integer()], N :: integer()) -> [integer()].
shuffle(Nums, N) ->
    lists:flatten(lists:zipwith(fun(X, Y) -> [X, Y] end, lists:sublist(Nums, 1, N), lists:sublist(Nums, N + 1, N))).