-module(solution).
-export([remove_adjacent_duplicates/1]).

remove_adjacent_duplicates(S) ->
    remove_adjacent_duplicates(S, []).

remove_adjacent_duplicates([], Acc) ->
    lists:reverse(Acc);
remove_adjacent_duplicates([H | T], Acc) ->
    case Acc of
        [] -> remove_adjacent_duplicates(T, [H]);
        [Prev | _] when Prev =:= H -> remove_adjacent_duplicates(T, tl(Acc));
        _ -> remove_adjacent_duplicates(T, [H | Acc])
    end.