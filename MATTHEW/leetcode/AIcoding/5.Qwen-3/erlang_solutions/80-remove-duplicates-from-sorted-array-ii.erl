-module(remove_duplicates_from_sorted_array_ii).
-export([remove_duplicates/1]).

remove_duplicates([]) -> 0;
remove_duplicates([H|T]) ->
    remove_duplicates(T, H, 1, [H]).

remove_duplicates([], _Prev, _Count, Acc) ->
    length(Acc);
remove_duplicates([H|T], Prev, Count, Acc) ->
    if
        H == Prev ->
            if
                Count < 2 ->
                    remove_duplicates(T, H, Count + 1, [H|Acc]);
                true ->
                    remove_duplicates(T, H, Count, Acc)
            end;
        true ->
            remove_duplicates(T, H, 1, [H|Acc])
    end.