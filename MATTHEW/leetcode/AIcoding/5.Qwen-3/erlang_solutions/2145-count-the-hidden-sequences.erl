-module(solution).
-export([count_hidden/1]).

count_hidden(A) ->
    count_hidden(A, 0, 0, 0).

count_hidden([], _, _, Acc) ->
    Acc;
count_hidden([H | T], Prev, Count, Acc) ->
    if
        H == 0 ->
            count_hidden(T, H, Count + 1, Acc);
        true ->
            if
                Prev == 0 ->
                    count_hidden(T, H, 1, Acc);
                true ->
                    if
                        abs(H - Prev) == 1 ->
                            count_hidden(T, H, Count + 1, Acc);
                        true ->
                            count_hidden(T, H, 1, Acc)
                    end
            end
    end.