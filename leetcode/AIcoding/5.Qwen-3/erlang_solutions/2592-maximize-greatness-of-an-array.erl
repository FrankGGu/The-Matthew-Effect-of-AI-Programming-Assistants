-module(maximize_greatness).
-export([maximize_greatness/1]).

maximize_greatness(A) ->
    Sorted = lists:sort(A),
    Max = length(A),
    Count = 0,
    helper(Sorted, 0, Count, Max).

helper([], _, Count, _) -> Count;
helper([H|T], Index, Count, Max) ->
    case Index < Max of
        true ->
            if
                H > lists:nth(Index + 1, Sorted) ->
                    helper(T, Index + 1, Count + 1, Max);
                true ->
                    helper(T, Index + 1, Count, Max)
            end;
        false ->
            Count
    end.