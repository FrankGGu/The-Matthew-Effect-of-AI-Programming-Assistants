-module(solution).
-export([remove_adjacent/1]).

remove_adjacent(S) ->
    remove_adjacent_helper(S, []).

remove_adjacent_helper([], Acc) ->
    lists:reverse(Acc);
remove_adjacent_helper([H | T], []) ->
    remove_adjacent_helper(T, [H]);
remove_adjacent_helper([H | T], [H | Acc]) ->
    remove_adjacent_helper(T, [H | Acc]);
remove_adjacent_helper([H | T], [H2 | Acc]) when H =:= H2 ->
    remove_adjacent_helper(T, Acc);
remove_adjacent_helper([H | T], Acc) ->
    remove_adjacent_helper(T, [H | Acc]).