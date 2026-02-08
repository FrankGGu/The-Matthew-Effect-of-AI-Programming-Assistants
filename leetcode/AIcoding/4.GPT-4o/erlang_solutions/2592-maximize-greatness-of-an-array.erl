-module(solution).
-export([maximize_greatness/1]).

maximize_greatness(Array) ->
    Sorted = lists:sort(Array),
    maximize(Sorted, 0, 0).

maximize([], _, Count) -> Count;
maximize([H | T], Last, Count) ->
    if
        H > Last ->
            maximize(T, H, Count + 1);
        true ->
            maximize(T, Last, Count)
    end.