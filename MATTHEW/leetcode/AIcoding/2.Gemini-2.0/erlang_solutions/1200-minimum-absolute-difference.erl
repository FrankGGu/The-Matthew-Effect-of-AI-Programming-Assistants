-module(minimum_absolute_difference).
-export([get_minimum_difference/1]).

get_minimum_difference(Arr) ->
    Sorted = lists:sort(Arr),
    get_min_diff(Sorted, hd(Sorted), tl(Sorted), infinity).

get_min_diff(_Sorted, _Prev, [], MinDiff) ->
    MinDiff;
get_min_diff(Sorted, Prev, [H|T], MinDiff) ->
    Diff = abs(H - Prev),
    NewMinDiff = min(MinDiff, Diff),
    get_min_diff(Sorted, H, T, NewMinDiff).