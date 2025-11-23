-module(solution).
-export([maximize_score/1]).

maximize_score(Ranges) ->
    Sorted = lists:sort(fun({A, B}, {C, D}) -> A < C end, Ranges),
    N = length(Sorted),
    DP = array:new([{size, N}, {default, 0}]),
    max_score(Sorted, DP, 0).

max_score([], _DP, _Index) ->
    0;
max_score([Range | Rest], DP, Index) ->
    {Start, End} = Range,
    Max = max(
        max_score(Rest, DP, Index + 1),
        (End - Start + 1) + max_score(find_next(Rest, End), DP, Index + 1)
    ),
    array:set(Index, Max, DP),
    Max.

find_next([], _) ->
    [];
find_next([Range | Rest], Target) ->
    {Start, _} = Range,
    if
        Start > Target -> [Range | Rest];
        true -> find_next(Rest, Target)
    end.