-module(solution).
-export([max_free_time/1]).

max_free_time(Intervals) ->
    Sorted = lists:sort(fun([A, _], [B, _]) -> A =< B end, Intervals),
    Merged = merge(Sorted, []),
    case Merged of
        [_] -> 0;
        _ ->
            Gaps = gaps(Merged),
            lists:max(Gaps)
    end.

merge([], Acc) -> lists:reverse(Acc);
merge([Interval], Acc) -> lists:reverse([Interval | Acc]);
merge([[S1, E1], [S2, E2] | Rest], Acc) ->
    if
        E1 >= S2 ->
            NewInterval = [S1, max(E1, E2)],
            merge([NewInterval | Rest], Acc);
        true ->
            merge([[S2, E2] | Rest], [[S1, E1] | Acc])
    end.

gaps([]) -> [];
gaps([_]) -> [];
gaps([[_, E1], [S2, _] | Rest]) ->
    [S2 - E1 | gaps([[S2, _] | Rest])].

max(A, B) when A > B -> A;
max(_, B) -> B.