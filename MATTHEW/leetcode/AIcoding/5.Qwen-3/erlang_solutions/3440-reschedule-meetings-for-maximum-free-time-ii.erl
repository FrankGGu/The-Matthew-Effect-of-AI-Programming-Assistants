-module(reschedule_meetings_for_maximum_free_time_ii).
-export([max_free_time/1]).

max_free_time(Meetings) ->
    Sorted = lists:sort(fun({A, B}, {C, D}) -> A < C end, Meetings),
    merge(Sorted, []).

merge([], Result) ->
    find_max_gap(Result);
merge([{Start, End} | Rest], []) ->
    merge(Rest, [{Start, End}]);
merge([{S1, E1} | Rest], [{S2, E2} | _] = Acc) when E1 < S2 ->
    merge(Rest, [{S1, E1} | Acc]);
merge([{S1, E1} | Rest], [{S2, E2} | _] = Acc) when S1 > E2 ->
    merge(Rest, [{S1, E1} | Acc]);
merge([{S1, E1} | Rest], [{S2, E2} | Tail] = Acc) ->
    NewE = max(E1, E2),
    merge(Rest, [{S2, NewE} | Tail]).

find_max_gap([]) ->
    0;
find_max_gap([_]) ->
    0;
find_max_gap([H | T]) ->
    find_max_gap(H, T, 0).

find_max_gap(_, [], Max) ->
    Max;
find_max_gap({_, End}, [{NextStart, _} | _], Max) ->
    Gap = NextStart - End,
    if
        Gap > Max -> find_max_gap({NextStart, End}, [], Gap);
        true -> find_max_gap({NextStart, End}, [], Max)
    end.