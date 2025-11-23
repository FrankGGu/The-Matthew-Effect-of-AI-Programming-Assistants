-module(solution).
-export([detectCycle/1]).

-record(node, {val, next = null}).

detectCycle(Head) ->
    case find_cycle(Head, [], []) of
        {ok, CycleStart} -> CycleStart;
        _ -> null
    end.

find_cycle(Head, Visited, Path) ->
    case Head of
        null -> {error, no_cycle};
        _ when lists:member(Head, Visited) -> {ok, Head};
        _ -> find_cycle(Head#node.next, [Head | Visited], [Head | Path])
    end.