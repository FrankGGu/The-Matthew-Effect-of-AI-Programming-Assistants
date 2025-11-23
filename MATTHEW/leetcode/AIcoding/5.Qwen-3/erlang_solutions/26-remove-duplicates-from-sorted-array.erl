-module(remove_duplicates_from_sorted_array).
-export([remove_duplicates/1]).

remove_duplicates([]) ->
    0;
remove_duplicates([H | T]) ->
    remove_duplicates(T, H, 1).

remove_duplicates([], _, Count) ->
    Count;
remove_duplicates([H | T], Last, Count) ->
    if
        H == Last ->
            remove_duplicates(T, Last, Count);
        true ->
            remove_duplicates(T, H, Count + 1)
    end.