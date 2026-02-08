-spec trap(Height :: [integer()]) -> integer().
trap(Height) ->
    trap(Height, length(Height), 0, 0, 0).

trap([], _, Left, Right, Result) -> Result;
trap([H | T], Size, Left, Right, Result) ->
    NewLeft = max(Left, H),
    NewRight = max(Right, Size - length(T) - 1),
    NewResult = Result + max(0, min(NewLeft, NewRight) - H),
    trap(T, Size, NewLeft, NewRight, NewResult).
