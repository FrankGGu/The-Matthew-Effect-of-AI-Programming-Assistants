-module(find_right_interval).
-export([find_right_interval/1]).

find_right_interval(Intervals) ->
    Sorted = lists:sort([{Start, Index} || {Start, _End} <- Intervals, Index <- lists:seq(0, length(Intervals)-1)]),
    lists:map(fun({Start, Index}) ->
        find_next(Sorted, Start, 0, length(Sorted)-1, Index)
    end, Sorted).

find_next(_, _, L, R, Index) when L > R ->
    -1;
find_next(Sorted, Target, L, R, Index) ->
    Mid = (L + R) div 2,
    {Start, I} = lists:nth(Mid+1, Sorted),
    if
        Start >= Target ->
            case find_next(Sorted, Target, L, Mid-1, Index) of
                -1 -> I;
                Val -> Val
            end;
        true ->
            find_next(Sorted, Target, Mid+1, R, Index)
    end.