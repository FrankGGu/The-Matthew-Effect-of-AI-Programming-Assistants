-spec trap(Height :: [integer()]) -> integer().
trap(Height) ->
    trap(Height, 0, 0, 0, 0).

trap([], _, _, LeftMax, RightMax) ->
    min(LeftMax, RightMax);
trap([H | T], Index, Total, LeftMax, RightMax) ->
    Left = lists:sublist(Height, Index),
    Right = lists:nthtail(Index + 1, Height),
    CurrentLeftMax = case Left of [] -> 0; _ -> lists:max(Left) end,
    CurrentRightMax = case Right of [] -> 0; _ -> lists:max(Right) end,
    Water = max(0, min(CurrentLeftMax, CurrentRightMax) - H),
    trap(T, Index + 1, Total + Water, max(LeftMax, H), max(RightMax, H)).