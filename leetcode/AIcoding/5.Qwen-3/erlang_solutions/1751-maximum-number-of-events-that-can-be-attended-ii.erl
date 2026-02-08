-module(max_events).
-export([max_events/1]).

max_events(Events) ->
    Sorted = lists:sort(fun({A, B}, {C, D}) -> A < C end, Events),
    N = length(Sorted),
    DP = array:new(N, {default, 0}),
    max_events(Sorted, 0, N, DP).

max_events(_, _, 0, _) ->
    0;
max_events(Sorted, Index, N, DP) ->
    case array:get(Index, DP) of
        V when is_integer(V) ->
            V;
        _ ->
            {Start, End} = lists:nth(Index + 1, Sorted),
            Max = max_events(Sorted, Index + 1, N, DP),
            Next = find_next(Sorted, Index, End),
            if
                Next == -1 ->
                    NewMax = max(Max, 1);
                true ->
                    NewMax = max(Max, 1 + max_events(Sorted, Next, N, DP))
            end,
            array:set(Index, NewMax, DP),
            NewMax
    end.

find_next(_, _, _) ->
    -1.

find_next(Sorted, Index, End) ->
    find_next(Sorted, Index + 1, End, length(Sorted)).

find_next(_, _, _, 0) ->
    -1;
find_next(Sorted, Index, End, N) ->
    {S, E} = lists:nth(Index + 1, Sorted),
    if
        S > End ->
            Index;
        true ->
            find_next(Sorted, Index + 1, End, N - 1)
    end.