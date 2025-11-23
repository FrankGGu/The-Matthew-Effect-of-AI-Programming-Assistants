-module(solution).
-export([min_deletions/1]).

min_deletions(S) ->
    min_deletions(S, 0, 0).

min_deletions([], _, _) ->
    0;
min_deletions([H | T], a_count, b_count) ->
    case H of
        $a ->
            min_deletions(T, a_count + 1, b_count);
        $b ->
            min_deletions(T, a_count, b_count + 1)
    end,
    min(a_count, b_count).