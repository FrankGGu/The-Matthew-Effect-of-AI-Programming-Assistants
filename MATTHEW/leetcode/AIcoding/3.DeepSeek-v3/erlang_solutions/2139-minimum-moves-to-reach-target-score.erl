-spec min_moves(Target :: integer(), MaxDoubles :: integer()) -> integer().
min_moves(Target, MaxDoubles) ->
    min_moves(Target, MaxDoubles, 0).

min_moves(1, _, Moves) ->
    Moves;
min_moves(Target, 0, Moves) ->
    Moves + Target - 1;
min_moves(Target, MaxDoubles, Moves) when Target rem 2 =:= 0, MaxDoubles > 0 ->
    min_moves(Target div 2, MaxDoubles - 1, Moves + 1);
min_moves(Target, MaxDoubles, Moves) ->
    min_moves(Target - 1, MaxDoubles, Moves + 1).