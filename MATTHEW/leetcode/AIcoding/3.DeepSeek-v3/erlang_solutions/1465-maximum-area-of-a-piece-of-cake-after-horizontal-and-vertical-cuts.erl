-spec max_area(Height :: integer(), Width :: integer(), HorizontalCuts :: [integer()], VerticalCuts :: [integer()]) -> integer().
max_area(Height, Width, HorizontalCuts, VerticalCuts) ->
    SortedH = lists:sort([0 | HorizontalCuts] ++ [Height]),
    SortedV = lists:sort([0 | VerticalCuts] ++ [Width]),
    MaxH = max_diff(SortedH),
    MaxV = max_diff(SortedV),
    (MaxH * MaxV) rem 1000000007.

max_diff(List) ->
    max_diff(List, 0).

max_diff([H1, H2 | T], Max) ->
    Diff = H2 - H1,
    NewMax = if Diff > Max -> Diff; true -> Max end,
    max_diff([H2 | T], NewMax);
max_diff(_, Max) ->
    Max.