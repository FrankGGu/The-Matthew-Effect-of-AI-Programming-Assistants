-spec min_cost_set_time(StartAt :: integer(), MoveCost :: integer(), PushCost :: integer(), TargetSeconds :: integer()) -> integer().
min_cost_set_time(StartAt, MoveCost, PushCost, TargetSeconds) ->
    MinCost = infinity,
    {MinCost1, _} = find_min_cost(StartAt, MoveCost, PushCost, TargetSeconds, MinCost),
    MinCost1.

find_min_cost(StartAt, MoveCost, PushCost, TargetSeconds, MinCost) ->
    MaxMinutes = TargetSeconds div 60,
    case MaxMinutes > 99 of
        true -> {MinCost, 99 * 60};
        false ->
            lists:foldl(fun(Minutes, {CurrentMinCost, _}) ->
                Seconds = TargetSeconds - Minutes * 60,
                case Seconds >= 0 andalso Seconds < 100 of
                    true ->
                        Digits = get_digits(Minutes, Seconds),
                        {Cost, _} = calculate_cost(StartAt, MoveCost, PushCost, Digits, 0, 0),
                        case Cost < CurrentMinCost of
                            true -> {Cost, Minutes * 60 + Seconds};
                            false -> {CurrentMinCost, Minutes * 60 + Seconds}
                        end;
                    false -> {CurrentMinCost, Minutes * 60 + Seconds}
                end
            end, {MinCost, 0}, lists:seq(0, MaxMinutes))
    end.

get_digits(Minutes, Seconds) ->
    case Minutes > 0 of
        true ->
            M1 = Minutes div 10,
            M2 = Minutes rem 10,
            S1 = Seconds div 10,
            S2 = Seconds rem 10,
            case M1 of
                0 -> [M2, S1, S2];
                _ -> [M1, M2, S1, S2]
            end;
        false ->
            S1 = Seconds div 10,
            S2 = Seconds rem 10,
            case S1 of
                0 -> [S2];
                _ -> [S1, S2]
            end
    end.

calculate_cost(StartAt, MoveCost, PushCost, [Digit | Rest], CurrentPos, TotalCost) ->
    NewCost = if
        CurrentPos =:= Digit -> TotalCost + PushCost;
        true -> TotalCost + MoveCost + PushCost
    end,
    calculate_cost(StartAt, MoveCost, PushCost, Rest, Digit, NewCost);
calculate_cost(_, _, _, [], _, TotalCost) -> {TotalCost, TotalCost}.