-module(boats_to_save_people).
-export([num_rescue_boats/1]).

num_rescue_boats(People) ->
    Sorted = lists:sort(People),
    num_rescue_boats(Sorted, 0, length(Sorted) - 1, 0).

num_rescue_boats(_, Left, Right, Count) when Left > Right ->
    Count;
num_rescue_boats(Sorted, Left, Right, Count) ->
    if
        lists:nth(Left + 1, Sorted) + lists:nth(Right + 1, Sorted) <= 50 ->
            num_rescue_boats(Sorted, Left + 1, Right - 1, Count + 1);
        true ->
            num_rescue_boats(Sorted, Left, Right - 1, Count + 1)
    end.