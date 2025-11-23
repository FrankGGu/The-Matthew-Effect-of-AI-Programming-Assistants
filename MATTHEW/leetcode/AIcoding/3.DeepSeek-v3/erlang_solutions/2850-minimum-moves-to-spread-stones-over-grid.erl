-module(solution).
-export([minimum_moves/1]).

minimum_moves(Grid) ->
    Stones = [],
    Holes = [],
    {Stones1, Holes1} = collect_stones_and_holes(Grid, 0, 0, Stones, Holes),
    Perms = permutations(Stones1),
    lists:min([calculate_moves(Perm, Holes1) || Perm <- Perms]).

collect_stones_and_holes([], _, _, Stones, Holes) ->
    {Stones, Holes};
collect_stones_and_holes([Row | Rest], I, J, Stones, Holes) ->
    {NewStones, NewHoles} = collect_row(Row, I, J, Stones, Holes),
    collect_stones_and_holes(Rest, I + 1, 0, NewStones, NewHoles).

collect_row([], _, _, Stones, Holes) ->
    {Stones, Holes};
collect_row([Val | Rest], I, J, Stones, Holes) ->
    case Val of
        0 -> collect_row(Rest, I, J + 1, Stones, [{I, J} | Holes]);
        N when N > 1 ->
            NewStones = lists:duplicate(N - 1, {I, J}) ++ Stones,
            collect_row(Rest, I, J + 1, NewStones, Holes);
        _ -> collect_row(Rest, I, J + 1, Stones, Holes)
    end.

permutations([]) ->
    [[]];
permutations(L) ->
    [[H | T] || H <- L, T <- permutations(L -- [H])].

calculate_moves(Stones, Holes) ->
    lists:sum([abs(X1 - X2) + abs(Y1 - Y2) || {{X1, Y1}, {X2, Y2}} <- lists:zip(Stones, Holes)]).