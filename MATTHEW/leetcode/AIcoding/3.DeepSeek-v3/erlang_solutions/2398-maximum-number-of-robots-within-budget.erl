-spec maximum_robots(ChargeTimes :: [integer()], RunningCosts :: [integer()], Budget :: integer()) -> integer().
maximum_robots(ChargeTimes, RunningCosts, Budget) ->
    N = length(ChargeTimes),
    MaxRobots = 0,
    {MaxRobots, _} = lists:foldl(fun(K, {Max, _}) ->
        case K > Max of
            true ->
                case check_window(ChargeTimes, RunningCosts, Budget, K) of
                    true -> {K, K};
                    false -> {Max, Max}
                end;
            false -> {Max, Max}
        end
    end, {MaxRobots, MaxRobots}, lists:seq(1, N)),
    MaxRobots.

check_window(ChargeTimes, RunningCosts, Budget, K) ->
    N = length(ChargeTimes),
    case K > N of
        true -> false;
        false ->
            Deque = queue:new(),
            TotalCost = 0,
            {Result, _, _} = lists:foldl(fun(I, {Found, Q, Sum}) ->
                Charge = lists:nth(I, ChargeTimes),
                Running = lists:nth(I, RunningCosts),
                Q1 = clean_deque(Q, Charge, I - K),
                Q2 = queue:in({Charge, I}, Q1),
                Sum1 = Sum + Running,
                case I >= K of
                    true ->
                        {MaxCharge, _} = queue:get(Q2),
                        CurrentCost = MaxCharge + K * Sum1,
                        case CurrentCost <= Budget of
                            true -> {true, Q2, Sum1 - lists:nth(I - K + 1, RunningCosts)};
                            false -> {Found, Q2, Sum1 - lists:nth(I - K + 1, RunningCosts)}
                        end;
                    false -> {Found, Q2, Sum1}
                end
            end, {false, Deque, TotalCost}, lists:seq(1, N)),
            Result
    end.

clean_deque(Q, Charge, LeftBound) ->
    case queue:is_empty(Q) of
        true -> Q;
        false ->
            {{Value, Index}, Q1} = queue:out(Q),
            case Index < LeftBound of
                true -> clean_deque(Q1, Charge, LeftBound);
                false ->
                    case Value >= Charge of
                        true -> queue:in({Value, Index}, Q1);
                        false -> clean_deque(Q1, Charge, LeftBound)
                    end
            end
    end.