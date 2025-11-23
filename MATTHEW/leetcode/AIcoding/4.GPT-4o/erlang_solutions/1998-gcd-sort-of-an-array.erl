-module(solution).
-export([gcd_sort/1]).

gcd_sort(List) ->
    SortedList = lists:sort(List),
    case is_gcd_sortable(List, SortedList) of
        true -> true;
        false -> false
    end.

is_gcd_sortable([], []) -> true;
is_gcd_sortable([H|T], Sorted) ->
    case lists:member(H, Sorted) of
        false -> false;
        true ->
            NewSorted = lists:filter(fun(X) -> X /= H end, Sorted),
            is_gcd_sortable(T, NewSorted)
    end.