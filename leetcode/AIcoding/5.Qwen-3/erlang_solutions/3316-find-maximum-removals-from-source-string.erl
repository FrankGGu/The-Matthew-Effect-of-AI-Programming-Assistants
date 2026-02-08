-module(solution).
-export([max_removals/2]).

max_removals(Source, Target) ->
    max_removals(Source, Target, 0, 0).

max_removals([], _, _, Count) ->
    Count;
max_removals(_, [], _, Count) ->
    Count;
max_removals([H|T], [H|T2], I, Count) ->
    max_removals(T, T2, I + 1, Count);
max_removals([H|T], [H2|T2], I, Count) ->
    if
        H == H2 ->
            max_removals(T, T2, I + 1, Count);
        true ->
            max_removals(T, [H2|T2], I, Count + 1)
    end.