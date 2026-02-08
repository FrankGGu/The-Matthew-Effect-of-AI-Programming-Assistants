-module(mountain_array).
-export([min_removals/1]).

min_removals(Arr) ->
    N = length(Arr),
    Left = left_increasing(Arr, N),
    Right = right_decreasing(Arr, N),
    Max = lists:max([lists:nth(I, Left) + lists:nth(I, Right) - 1 || I <- lists:seq(1, N)]),
    N - Max.

left_increasing(Arr, N) ->
    Left = lists:duplicate(N, 1),
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc2) ->
            if
                J < I andalso lists:nth(J, Arr) < lists:nth(I, Arr) ->
                    lists:put(I, lists:nth(J, Acc2) + 1, Acc2);
                true ->
                    Acc2
            end
        end, Acc, lists:seq(1, I-1))
    end, Left, lists:seq(1, N)).

right_decreasing(Arr, N) ->
    Right = lists:duplicate(N, 1),
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc2) ->
            if
                J > I andalso lists:nth(J, Arr) < lists:nth(I, Arr) ->
                    lists:put(I, lists:nth(J, Acc2) + 1, Acc2);
                true ->
                    Acc2
            end
        end, Acc, lists:seq(I+1, N))
    end, Right, lists:seq(1, N)).