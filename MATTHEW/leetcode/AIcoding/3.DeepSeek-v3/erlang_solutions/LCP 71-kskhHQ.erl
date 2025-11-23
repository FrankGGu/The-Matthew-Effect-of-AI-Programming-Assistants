-spec trap(Height :: [integer()]) -> integer().
trap(Height) ->
    trap(Height, 0, 0, 0, 0, length(Height)).

trap([], _, _, _, Water, _) -> Water;
trap([H | T], LeftMax, RightMax, Left, Right, Len) when Left < Right ->
    NewLeftMax = max(LeftMax, H),
    trap(T, NewLeftMax, RightMax, Left + 1, Right, Len) + max(0, NewLeftMax - H);
trap(Height, LeftMax, RightMax, Left, Right, Len) ->
    Index = Len - Right - 1,
    H = lists:nth(Index, Height),
    NewRightMax = max(RightMax, H),
    trap(Height, LeftMax, NewRightMax, Left, Right + 1, Len) + max(0, NewRightMax - H).