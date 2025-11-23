-spec max_area(H :: integer(), W :: integer(), HorizontalCuts :: [integer()], VerticalCuts :: [integer()]) -> integer().
max_area(H, W, HorizontalCuts, VerticalCuts) ->
    Mod = 1_000_000_007,
    MaxHeightDiff = get_max_diff(H, HorizontalCuts),
    MaxWidthDiff = get_max_diff(W, VerticalCuts),
    (MaxHeightDiff rem Mod * MaxWidthDiff rem Mod) rem Mod.

get_max_diff(TotalDim, CutsList) ->
    SortedPoints = lists:sort([0 | [TotalDim | CutsList]]),
    get_max_diff_recur(tl(SortedPoints), hd(SortedPoints), 0).

get_max_diff_recur([], _Prev, MaxDiff) ->
    MaxDiff;
get_max_diff_recur([Current | Rest], Prev, AccMaxDiff) ->
    Diff = Current - Prev,
    NewMaxDiff = max(AccMaxDiff, Diff),
    get_max_diff_recur(Rest, Current, NewMaxDiff).