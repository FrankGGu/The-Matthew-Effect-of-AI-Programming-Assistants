-module(linked_list_cycle_ii).
-export([detectCycle/1]).

detectCycle(Head) ->
    detectCycle(Head, Head, Head).

detectCycle(Head, Slow, Fast) ->
    case {Slow, Fast} of
        {null, _} ->
            null;
        {_, null} ->
            null;
        {_, {null, _}} ->
            null;
        _ ->
            SlowNext = get_next(Slow),
            FastNext = get_next(get_next(Fast)),
            case {SlowNext, FastNext} of
                {null, _} ->
                    null;
                {_, null} ->
                    null;
                 _ ->
                    if
                        SlowNext == FastNext ->
                            find_intersection(Head, SlowNext);
                        true ->
                            detectCycle(Head, SlowNext, FastNext)
                    end
            end
    end.

find_intersection(Head, Intersection) ->
    find_intersection(Head, Intersection, Head).

find_intersection(Head, Intersection, Curr) ->
    if
        Curr == Intersection ->
            Curr;
        true ->
            find_intersection(Head, Intersection, get_next(Curr))
    end.

get_next(null) ->
    null;
get_next({Val, Next}) ->
    Next.