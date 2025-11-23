-module(solution).
-export([remove_adjacent/1]).

remove_adjacent(S) ->
    remove_adjacent(S, []).

remove_adjacent([], Acc) ->
    lists:reverse(Acc);
remove_adjacent([H | T], []) ->
    remove_adjacent(T, [H]);
remove_adjacent([H | T], [H | _] = Acc) ->
    remove_adjacent(T, Acc);
remove_adjacent([H | T], Acc) ->
    remove_adjacent(T, [H | Acc]).