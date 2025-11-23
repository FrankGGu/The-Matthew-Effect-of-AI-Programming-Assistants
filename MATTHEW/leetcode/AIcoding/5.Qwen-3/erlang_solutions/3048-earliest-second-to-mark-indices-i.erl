-module(earliest_second_to_mark_indices).
-export([latest_second/2]).

latest_second(Indices, S) ->
    N = length(Indices),
    Sorted = lists:sort(Indices),
    Last = lists:last(Sorted),
    Count = 1,
    latest_second(Sorted, S, Last, Count).

latest_second([], _, _, _) -> -1;
latest_second([I | Is], S, Last, Count) ->
    if
        I == Last ->
            case lists:nth(Count, S) of
                $1 -> Count;
                _ -> latest_second(Is, S, Last, Count + 1)
            end;
        true ->
            case lists:nth(Count, S) of
                $1 -> latest_second(Is, S, Last, Count + 1);
                _ -> latest_second([I | Is], S, Last, Count + 1)
            end
    end.