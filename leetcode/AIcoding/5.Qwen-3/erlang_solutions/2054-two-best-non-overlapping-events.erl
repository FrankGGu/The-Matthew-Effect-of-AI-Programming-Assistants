-module(two_best_non_overlapping_events).
-export([max_value/1]).

max_value(Events) ->
    Sorted = lists:sort(fun({A, B}, {C, D}) -> A < C end, Events),
    N = length(Sorted),
    DP = array:new(N, {default, 0}),
    MaxVal = array:new(N, {default, 0}),
    lists:foreach(fun(I) -> update_dp(I, Sorted, DP, MaxVal) end, lists:seq(0, N-1)),
    array:get(N-1, MaxVal).

update_dp(I, Sorted, DP, MaxVal) ->
    {Start, End} = array:get(I, Sorted),
    Value = End - Start + 1,
    array:set(I, Value, DP),
    Prev = find_prev(I, Sorted),
    if
        Prev >= 0 ->
            array:set(I, array:get(I, DP) + array:get(Prev, DP), DP);
        true ->
            ok
    end,
    if
        I == 0 ->
            array:set(I, array:get(I, DP), MaxVal);
        true ->
            array:set(I, max(array:get(I-1, MaxVal), array:get(I, DP)), MaxVal)
    end.

find_prev(I, Sorted) ->
    {Start, End} = array:get(I, Sorted),
    lists:foldl(fun(J, Acc) ->
        if
            Acc /= -1 -> Acc;
            true ->
                {S, E} = array:get(J, Sorted),
                if
                    E <= Start -> J;
                    true -> Acc
                end
        end
    end, -1, lists:seq(0, I-1)).