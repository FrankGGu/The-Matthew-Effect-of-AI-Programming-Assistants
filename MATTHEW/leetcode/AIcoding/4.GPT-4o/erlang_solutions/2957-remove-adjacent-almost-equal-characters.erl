-module(solution).
-export([remove_adjacent_almost_equal/1]).

remove_adjacent_almost_equal(S) ->
    remove(S, []).

remove([], Acc) ->
    lists:reverse(Acc);
remove([H | T], Acc) ->
    case Acc of
        [] -> remove(T, [H]);
        [Prev | _] when abs(Prev - H) <= 1 -> remove(T, Acc);
        _ -> remove(T, [H | Acc])
    end.