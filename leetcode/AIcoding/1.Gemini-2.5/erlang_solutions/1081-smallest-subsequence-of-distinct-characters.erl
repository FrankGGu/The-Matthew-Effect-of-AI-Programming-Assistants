-module(solution).
-export([smallest_subsequence/1]).

smallest_subsequence(S) ->
    LastOccurrences = build_last_occurrences(S),
    lists:reverse(do_smallest_subsequence(S, 0, [], gb_sets:empty(), LastOccurrences)).

build_last_occurrences(S) ->
    build_last_occurrences(S, 0, gb_trees:empty()).

build_last_occurrences([], _Idx, Acc) -> Acc;
build_last_occurrences([H | T], Idx, Acc) ->
    build_last_occurrences(T, Idx + 1, gb_trees:insert(H, Idx, Acc)).

do_smallest_subsequence([], _Idx, Result, _Seen, _LastOccurrences) ->
    Result;
do_smallest_subsequence([C | T], Idx, Result, Seen, LastOccurrences) ->
    if gb_sets:is_member(C, Seen) ->
        do_smallest_subsequence(T, Idx + 1, Result, Seen, LastOccurrences);
    true ->
        {PoppedResult, PoppedSeen} = pop_while_condition(C, Idx, Result, Seen, LastOccurrences),
        do_smallest_subsequence(T, Idx + 1, [C | PoppedResult], gb_sets:add(C, PoppedSeen), LastOccurrences)
    end.

pop_while_condition(C, CurrentIdx, Result, Seen, LastOccurrences) ->
    case Result of
        [] -> {[], Seen};
        [Top | RestResult] ->
            LastOccOfTop = gb_trees:get(Top, LastOccurrences),
            if Top > C andalso LastOccOfTop > CurrentIdx ->
                pop_while_condition(C, CurrentIdx, RestResult, gb_sets:delete(Top, Seen), LastOccurrences);
            true ->
                {Result, Seen}
            end
    end.