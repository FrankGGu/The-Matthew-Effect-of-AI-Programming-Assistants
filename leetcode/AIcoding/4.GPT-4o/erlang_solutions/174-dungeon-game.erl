-spec calculate_minimum_hp(Dungeon :: [[integer()]]) -> integer().
calculate_minimum_hp(Dungeon) ->
    {M, N} = list:tuple_size(Dungeon),
    calculate_minimum_hp(Dungeon, M, N).

calculate_minimum_hp(Dungeon, M, N) ->
    Matrix = lists:duplicate(M, lists:duplicate(N, 0)),
    calculate_minimum_hp(Dungeon, Matrix, M, N, M-1, N-1).

calculate_minimum_hp(Dungeon, Matrix, M, N, 0, 0) ->
    Max(1 - lists:nth(1, lists:nth(1, Dungeon)) + lists:nth(1, lists:nth(1, Matrix)), 1);
calculate_minimum_hp(Dungeon, Matrix, M, N, X, Y) ->
    if
        X == M - 1 -> lists:set_elem(X, lists:set_elem(Y, lists:nth(Y, Dungeon), lists:nth(1, lists:nth(Y, Dungeon)))), ;
  true -> Max.
.end
