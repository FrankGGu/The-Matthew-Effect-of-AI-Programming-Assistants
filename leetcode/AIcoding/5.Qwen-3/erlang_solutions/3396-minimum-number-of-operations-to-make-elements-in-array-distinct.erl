-module(min_operations).
-export([min_operations/1]).

min_operations([]) -> 0;
min_operations([H | T]) ->
    Sorted = lists:sort([H | T]),
    min_operations(Sorted, 0, hd(Sorted)).

min_operations([], _, _) -> 0;
min_operations([H | T], Acc, Prev) ->
    if
        H > Prev -> min_operations(T, Acc, H);
        true ->
            NewVal = Prev + 1,
            min_operations(T, Acc + (NewVal - H), NewVal)
    end.