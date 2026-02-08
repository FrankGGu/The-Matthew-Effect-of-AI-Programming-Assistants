-module(stone_game_v).
-export([stoneGameV/1]).

stoneGameV(StoneList) ->
    Len = length(StoneList),
    Max = lists:foldl(fun(X, Acc) -> max(X, Acc) end, 0, StoneList),
    DP = array:new(Len, {0, 0}),
    helper(StoneList, 0, Len - 1, DP, Max).

helper(StoneList, L, R, DP, Max) when L > R ->
    {0, 0};
helper(StoneList, L, R, DP, Max) when L == R ->
    {0, lists:nth(L + 1, StoneList)};
helper(StoneList, L, R, DP, Max) ->
    case array:get(L, R, DP) of
        {Left, Right} ->
            {Left, Right};
        _ ->
            LeftSum = helper(StoneList, L + 1, R, DP, Max),
            RightSum = helper(StoneList, L, R - 1, DP, Max),
            LeftTotal = element(1, LeftSum) + element(2, LeftSum),
            RightTotal = element(1, RightSum) + element(2, RightSum),
            if
                LeftTotal > RightTotal ->
                    NewLeft = element(1, LeftSum) + element(2, LeftSum),
                    NewRight = element(2, LeftSum),
                    array:set(L, R, {NewLeft, NewRight}, DP),
                    {NewLeft, NewRight};
                true ->
                    NewLeft = element(1, RightSum),
                    NewRight = element(1, RightSum) + element(2, RightSum),
                    array:set(L, R, {NewLeft, NewRight}, DP),
                    {NewLeft, NewRight}
            end
    end.

array:new(Size, Initial) ->
    array:new(Size, {Initial, Initial}).

array:get(L, R, Array) ->
    array:get(R, array:get(L, Array)).

array:set(L, R, Value, Array) ->
    array:set(L, array:set(R, Value, array:get(L, Array)), Array).