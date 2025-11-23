-module(solution).
-export([minimum_absolute_difference/1]).

minimum_absolute_difference(List) ->
    Sorted = lists:sort(List),
    MinDiff = lists:foldl(fun(X, {Prev, Min}) ->
        Diff = abs(X - Prev),
        {X, min(Diff, Min)}
    end, {hd(Sorted), infinity}, tl(Sorted)),
    MinDiff.