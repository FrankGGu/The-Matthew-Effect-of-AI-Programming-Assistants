-module(surplus_water).
-export([trap/1]).

trap(Height) ->
    trap(Height, 0, 0, 0, 0, []).

trap([], _, _, _, _, Acc) ->
    lists:reverse(Acc);
trap([H | T], LeftMax, RightMax, Left, Right, Acc) ->
    if
        H < LeftMax andalso H < RightMax ->
            NewWater = min(LeftMax, RightMax) - H,
            trap(T, LeftMax, RightMax, Left, Right, [NewWater | Acc]);
        true ->
            NewLeftMax = max(LeftMax, H),
            NewRightMax = max(RightMax, H),
            trap(T, NewLeftMax, NewRightMax, Left + 1, Right - 1, Acc)
    end.