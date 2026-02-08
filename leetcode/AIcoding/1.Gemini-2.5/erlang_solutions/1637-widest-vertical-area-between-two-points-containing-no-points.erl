-module(solution).
-export([maxWidthOfVerticalArea/1]).

-spec maxWidthOfVerticalArea(Points :: [[integer()]]) -> integer().
maxWidthOfVerticalArea(Points) ->
    XCoords = lists:map(fun([X, _]) -> X end, Points),
    SortedXCoords = lists:sort(XCoords),
    find_max_diff(SortedXCoords, 0).

find_max_diff([_], MaxDiff) ->
    MaxDiff;
find_max_diff([H1, H2 | T], MaxDiff) ->
    CurrentDiff = H2 - H1,
    NewMaxDiff = max(MaxDiff, CurrentDiff),
    find_max_diff([H2 | T], NewMaxDiff).