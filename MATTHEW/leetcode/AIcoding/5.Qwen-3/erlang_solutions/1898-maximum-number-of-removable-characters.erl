-module(max_removable).
-export([max_removals/2]).

max_removals(Chars, Target) ->
    max_removals(Chars, Target, 0, 0, 0).

max_removals([], _, _, _, Count) ->
    Count;
max_removals(_, [], _, _, Count) ->
    Count;
max_removals([C | T1], [T | T2], I, J, Count) ->
    if
        C == T ->
            max_removals(T1, T2, I + 1, J + 1, Count + 1);
        true ->
            max_removals(T1, T2, I + 1, J, Count)
    end.