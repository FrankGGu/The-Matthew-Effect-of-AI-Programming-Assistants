-spec min_number_game(Nums :: [integer()]) -> [integer()].
min_number_game(Nums) ->
    Sorted = lists:sort(Nums),
    min_number_game(Sorted, []).

min_number_game([], Acc) ->
    lists:reverse(Acc);
min_number_game([A, B | Rest], Acc) ->
    min_number_game(Rest, [B, A | Acc]).