-module(solution).
-export([can_be_sorted/1]).

can_be_sorted(Arr) ->
    Sorted = lists:sort(Arr),
    Length = length(Arr),
    can_be_sorted(Arr, Sorted, 0, Length).

can_be_sorted(_, _, Index, Length) when Index >= Length ->
    true;
can_be_sorted(Arr, Sorted, Index, Length) ->
    case lists:nth(Index + 1, Arr) of
        undefined ->
            true;
        Val ->
            if
                lists:nth(Index + 1, Sorted) == Val ->
                    can_be_sorted(Arr, Sorted, Index + 1, Length);
                true ->
                    false
            end
    end.