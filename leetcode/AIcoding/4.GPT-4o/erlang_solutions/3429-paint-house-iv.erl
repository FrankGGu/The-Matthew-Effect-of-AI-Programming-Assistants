-module(solution).
-export([min_cost/3]).

min_cost(Colors, Houses, Target) ->
    N = length(Houses),
    ColorCount = length(Colors),
    %% Initialize the DP table
    DP = lists:duplicate(N + 1, lists:duplicate(Target + 1, infinity)),
    DP1 = lists:duplicate(N + 1, lists:duplicate(Target + 1, 0)),
    DP2 = lists:duplicate(N + 1, lists:duplicate(Target + 1, 0)),
    %% Base case
    DP1 = lists:map(fun({Cost, House}) -> lists:map(fun(Color) -> if House =:= Color -> Cost; true -> infinity end end, Colors) end, lists:zip(Houses, lists:seq(1, N))),
    %% Fill the DP table
    lists:foldl(fun(HouseIdx, Acc) ->
        lists:foldl(fun(ColorIdx, Acc1) ->
            lists:foldl(fun(TargetIdx, Acc2) ->
                %% Update DP table for each house and color
                %% Calculate new cost
                NewCost = if HouseIdx =:= 1 -> Acc1; true -> Acc1 + lists:nth(ColorIdx + 1, HouseIdx) end,
                TargetLeft = TargetIdx - (if HouseIdx =:= 1 -> 0; true -> 1 end),
                %% Check if the new cost is minimal and update
                min(Acc2, NewCost)
            end, Acc1, lists:seq(1, Target))
        end, Acc, lists:seq(1, ColorCount))
    end, DP1, lists:seq(1, N),
    %% Return the result
    lists:foldl(fun(TargetIdx, Acc) -> min(Acc, lists:nth(TargetIdx + 1, DP2)) end, infinity, lists:seq(1, Target)).