-module(solution).
-export([trap/1]).

trap(HeightList) ->
    case length(HeightList) of
        Len when Len < 3 -> 0;
        _ ->
            MaxLefts = calculate_max_left(HeightList),
            MaxRights = calculate_max_right(HeightList),
            calculate_total_water(MaxLefts, MaxRights, HeightList, 0)
    end.

calculate_max_left(HeightList) ->
    {ResultAcc, _} = lists:foldl(
            fun(H, {Acc, CurrentMax}) ->
                NewMax = max(CurrentMax, H),
                {[NewMax | Acc], NewMax}
            end,
            {[], 0},
            HeightList
        ),
    lists:reverse(ResultAcc).

calculate_max_right(HeightList) ->
    {ResultAcc, _} = lists:foldl(
            fun(H, {Acc, CurrentMax}) ->
                NewMax = max(CurrentMax, H),
                {[NewMax | Acc], NewMax}
            end,
            {[], 0},
            lists:reverse(HeightList)
        ),
    ResultAcc.

calculate_total_water([], [], [], Total) ->
    Total;
calculate_total_water([ML | MLT], [MR | MRT], [H | HT], CurrentTotal) ->
    WaterAtPos = max(0, min(ML, MR) - H),
    calculate_total_water(MLT, MRT, HT, CurrentTotal + WaterAtPos).