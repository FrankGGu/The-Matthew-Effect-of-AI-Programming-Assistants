-module(solution).
-export([remove_boxes/1]).

remove_boxes(Boxes) ->
    N = length(Boxes),
    if N == 0 -> 0;
       true ->
            _ = ets:new(remove_boxes_memo, [set, public, named_table]),
            Arr = array:from_list(Boxes),
            Points = solve_ets(Arr, 0, N - 1, 0),
            _ = ets:delete(remove_boxes_memo),
            Points
    end.

solve_ets(Arr, I, J, K) ->
    if I > J ->
        0;
    true ->
        Key = {I, J, K},
        case ets:lookup(remove_boxes_memo, Key) of
            [{Key, Points}] ->
                Points;
            [] ->
                Points1 = (K + 1) * (K + 1),
                RemainingPoints1 = solve_ets(Arr, I, J - 1, 0),
                TotalPoints1 = Points1 + RemainingPoints1,

                CurrentColor = array:get(J, Arr),
                MaxPointsFromOption2 = find_max_p_ets(Arr, I, J, K, J - 1, CurrentColor, 0),

                MaxTotalPoints = max(TotalPoints1, MaxPointsFromOption2),
                _ = ets:insert(remove_boxes_memo, {Key, MaxTotalPoints}),
                MaxTotalPoints
        end
    end.

find_max_p_ets(Arr, I, J, K, P, TargetColor, CurrentMax) ->
    if P < I ->
        CurrentMax;
    true ->
        PColor = array:get(P, Arr),
        if PColor == TargetColor ->
            PointsLeft = solve_ets(Arr, I, P, K + 1),
            PointsMiddle = solve_ets(Arr, P + 1, J - 1, 0),
            CombinedPoints = PointsLeft + PointsMiddle,
            NewMax = max(CurrentMax, CombinedPoints),
            find_max_p_ets(Arr, I, J, K, P - 1, TargetColor, NewMax);
        true ->
            find_max_p_ets(Arr, I, J, K, P - 1, TargetColor, CurrentMax)
        end
    end.