-module(solution).
-export([remove_adjacent/1]).

remove_adjacent(S) ->
    remove_adjacent_helper(S, []).

remove_adjacent_helper([], Acc) ->
    lists:reverse(Acc);
remove_adjacent_helper([H | T], Acc) ->
    case Acc of
        [] -> remove_adjacent_helper(T, [H]);
        [Last | _] when Last =:= H -> remove_adjacent_helper(T, Acc);
        _ -> remove_adjacent_helper(T, [H | Acc])
    end.