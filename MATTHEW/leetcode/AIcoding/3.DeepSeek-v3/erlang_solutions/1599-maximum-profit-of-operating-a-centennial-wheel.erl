-spec min_operations_max_profit(Customers :: [integer()], BoardingCost :: integer(), RunningCost :: integer()) -> integer().
min_operations_max_profit(Customers, BoardingCost, RunningCost) ->
    min_operations_max_profit(Customers, 0, 0, 0, 0, -1, BoardingCost, RunningCost).

min_operations_max_profit([], Waiting, Rotations, CurrentProfit, MaxProfit, BestRotation, BoardingCost, RunningCost) ->
    case Waiting > 0 of
        true ->
            Board = min(4, Waiting),
            NewProfit = CurrentProfit + Board * BoardingCost - RunningCost,
            NewRotations = Rotations + 1,
            if 
                NewProfit > MaxProfit -> 
                    min_operations_max_profit([], Waiting - Board, NewRotations, NewProfit, NewProfit, NewRotations, BoardingCost, RunningCost);
                true ->
                    min_operations_max_profit([], Waiting - Board, NewRotations, NewProfit, MaxProfit, BestRotation, BoardingCost, RunningCost)
            end;
        false ->
            if 
                MaxProfit > 0 -> BestRotation;
                true -> -1
            end
    end;
min_operations_max_profit([C | Rest], Waiting, Rotations, CurrentProfit, MaxProfit, BestRotation, BoardingCost, RunningCost) ->
    NewWaiting = Waiting + C,
    Board = min(4, NewWaiting),
    NewProfit = CurrentProfit + Board * BoardingCost - RunningCost,
    NewRotations = Rotations + 1,
    NewBestRotation = if 
        NewProfit > MaxProfit -> NewRotations;
        true -> BestRotation
    end,
    min_operations_max_profit(Rest, NewWaiting - Board, NewRotations, NewProfit, max(MaxProfit, NewProfit), NewBestRotation, BoardingCost, RunningCost).