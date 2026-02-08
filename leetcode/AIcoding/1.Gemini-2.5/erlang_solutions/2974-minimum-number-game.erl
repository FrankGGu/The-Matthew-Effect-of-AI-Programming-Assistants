-spec number_game(Nums :: [integer()]) -> [integer()].
number_game(Nums) ->
    SortedNums = lists:sort(Nums),
    build_game_array(SortedNums, []).

build_game_array([], Acc) ->
    lists:reverse(Acc);
build_game_array([AliceChoice, BobChoice | Rest], Acc) ->
    build_game_array(Rest, [AliceChoice, BobChoice | Acc]).