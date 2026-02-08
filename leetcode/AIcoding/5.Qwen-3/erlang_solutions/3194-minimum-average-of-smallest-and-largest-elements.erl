-module(solution).
-export([minimumAverage/1]).

minimumAverage(Numbers) ->
    Sorted = lists:sort(Numbers),
    N = length(Sorted),
    lists:foldl(fun(I, Acc) ->
        A = lists:nth(I, Sorted),
        B = lists:nth(N - I + 1, Sorted),
        Avg = (A + B) / 2,
        if
            Avg < Acc -> Avg;
            true -> Acc
        end
    end, infinity, lists:seq(1, N div 2)).