-module(solution).
-export([minimum_moves/1]).

-spec minimum_moves(S :: unicode:unicode_binary()) -> integer().
minimum_moves(S) ->
    minimum_moves_list(unicode:characters_to_list(S), 0).

minimum_moves_list([], Moves) ->
    Moves;
minimum_moves_list([$O | T], Moves) ->
    minimum_moves_list(drop_n(T, 2), Moves + 1);
minimum_moves_list([$X | T], Moves) ->
    minimum_moves_list(T, Moves).

drop_n(List, N) when N =< 0 ->
    List;
drop_n([], _N) ->
    [];
drop_n([_H | T], N) ->
    drop_n(T, N - 1).