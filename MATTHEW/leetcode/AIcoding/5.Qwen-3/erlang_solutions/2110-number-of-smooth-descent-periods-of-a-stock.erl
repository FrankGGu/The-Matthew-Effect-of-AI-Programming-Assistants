-module(solution).
-export([num_smooth_descents/1]).

num_smooth_descents(Prices) ->
    num_smooth_descents(Prices, 0, 0).

num_smooth_descents([], _Prev, Count) ->
    Count;
num_smooth_descents([P | T], Prev, Count) ->
    if
        Prev == 0 ->
            num_smooth_descents(T, P, Count + 1);
        true ->
            if
                P + 1 == Prev ->
                    num_smooth_descents(T, P, Count + 1);
                true ->
                    num_smooth_descents(T, P, Count)
            end
    end.