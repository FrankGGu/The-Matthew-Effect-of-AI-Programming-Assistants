-module(solution).
-export([max_profit_wheel/3]).

max_profit_wheel(Customers, BoardingCost, RunningCost) ->
    simulate_customers(Customers, 0, 0, -1, -1, 0, BoardingCost, RunningCost).

simulate_customers([], WaitingCustomers, CurrentProfit, MaxProfit, MaxProfitRotations, Rotations, BoardingCost, RunningCost) ->
    simulate_remaining(WaitingCustomers, CurrentProfit, MaxProfit, MaxProfitRotations, Rotations, BoardingCost, RunningCost);
simulate_customers([H | T], WaitingCustomers, CurrentProfit, MaxProfit, MaxProfitRotations, Rotations, BoardingCost, RunningCost) ->
    NewWaitingCustomers = WaitingCustomers + H,
    NewRotations = Rotations + 1,
    ProfitAfterRunningCost = CurrentProfit - RunningCost,
    Boarded = min(NewWaitingCustomers, 4),
    RemainingWaitingCustomers = NewWaitingCustomers - Boarded,
    NewCurrentProfit = ProfitAfterRunningCost + Boarded * BoardingCost,

    {UpdatedMaxProfit, UpdatedMaxProfitRotations} = update_max_profit(
        NewCurrentProfit, NewRotations, MaxProfit, MaxProfitRotations),

    simulate_customers(T, RemainingWaitingCustomers, NewCurrentProfit, UpdatedMaxProfit, UpdatedMaxProfitRotations, NewRotations, BoardingCost, RunningCost).

simulate_remaining(0, _CurrentProfit, _MaxProfit, MaxProfitRotations, _Rotations, _BoardingCost, _RunningCost) ->
    MaxProfitRotations;
simulate_remaining(WaitingCustomers, CurrentProfit, MaxProfit, MaxProfitRotations, Rotations, BoardingCost, RunningCost) ->
    NewRotations = Rotations + 1,
    ProfitAfterRunningCost = CurrentProfit - RunningCost,
    Boarded = min(WaitingCustomers, 4),
    RemainingWaitingCustomers = WaitingCustomers - Boarded,
    NewCurrentProfit = ProfitAfterRunningCost + Boarded * BoardingCost,

    {UpdatedMaxProfit, UpdatedMaxProfitRotations} = update_max_profit(
        NewCurrentProfit, NewRotations, MaxProfit, MaxProfitRotations),

    simulate_remaining(RemainingWaitingCustomers, NewCurrentProfit, UpdatedMaxProfit, UpdatedMaxProfitRotations, NewRotations, BoardingCost, RunningCost).

update_max_profit(CurrentProfit, Rotations, MaxProfit, MaxProfitRotations) ->
    if
        CurrentProfit > MaxProfit ->
            {CurrentProfit, Rotations};
        CurrentProfit == MaxProfit ->
            {MaxProfit, min(MaxProfitRotations, Rotations)};
        true ->
            {MaxProfit, MaxProfitRotations}
    end.