-module(paint_house_iv).
-export([min_cost/2]).

min_cost(Houses, CostMatrix) ->
    min_cost_helper(Houses, CostMatrix, 0, 0, 0, []).

min_cost_helper([], _, _, _, _, Acc) ->
    lists:min(Acc);
min_cost_helper([_|RestHouses], CostMatrix, HouseIndex, LastColor, TotalCost, Acc) ->
    case RestHouses of
        [] ->
            Colors = lists:seq(1, length(lists:nth(1, CostMatrix))),
            FilteredColors = lists:filter(fun(Color) -> Color /= LastColor end, Colors),
            NewAcc = lists:map(fun(Color) -> TotalCost + lists:nth(Color, lists:nth(HouseIndex+1, CostMatrix)) end, FilteredColors),
            min_cost_helper(RestHouses, CostMatrix, HouseIndex + 1, LastColor, TotalCost, Acc ++ NewAcc);
        _ ->
            Colors = lists:seq(1, length(lists:nth(1, CostMatrix))),
            FilteredColors = lists:filter(fun(Color) -> Color /= LastColor end, Colors),
            lists:foldl(fun(Color, Acc2) ->
                min_cost_helper(RestHouses, CostMatrix, HouseIndex + 1, Color, TotalCost + lists:nth(Color, lists:nth(HouseIndex+1, CostMatrix)), Acc2)
            end, Acc, FilteredColors)
    end.