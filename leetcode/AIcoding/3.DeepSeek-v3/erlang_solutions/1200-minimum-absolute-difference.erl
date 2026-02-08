-spec minimum_abs_difference(Arr :: [integer()]) -> [[integer()]].
minimum_abs_difference(Arr) ->
    Sorted = lists:sort(Arr),
    Pairs = lists:zip(lists:droplast(Sorted), tl(Sorted)),
    Diffs = [{abs(X - Y), [X, Y]} || {X, Y} <- Pairs],
    MinDiff = lists:min([Diff || {Diff, _} <- Diffs]),
    lists:sort([[X, Y] || {Diff, [X, Y]} <- Diffs, Diff == MinDiff]).