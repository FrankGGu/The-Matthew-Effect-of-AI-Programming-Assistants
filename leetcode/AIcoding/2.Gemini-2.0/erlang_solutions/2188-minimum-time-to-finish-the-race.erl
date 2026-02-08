-module(minimum_time_to_finish_race).
-export([minimum_time/3]).

minimum_time(tire, change_time, num_laps) ->
    N = length(tire),
    MaxLap = min(num_laps, 20),
    Cost = lists:duplicate(N, []),
    for(I, 1, N) do
        Tire_I = lists:nth(I, tire),
        Cost_I = calculate_cost(Tire_I, MaxLap, change_time),
        lists:nth(I, Cost) = Cost_I
    end,

    DP = lists:duplicate(num_laps + 1, infinity),
    lists:nth(1, DP) = 0,

    for(Lap, 1, num_laps) do
        for(I, 1, N) do
            Cost_I = lists:nth(I, Cost);
            for(J, 1, min(Lap, MaxLap)) do
                DP_Prev = lists:nth(Lap - J + 1, DP);
                Cost_J = lists:nth(J, Cost_I);
                lists:nth(Lap + 1, DP) = min(lists:nth(Lap + 1, DP), DP_Prev + Cost_J + change_time)
            end
        end
    end,

    lists:nth(num_laps + 1, DP) - change_time.

calculate_cost({F, R}, MaxLap, ChangeTime) ->
    calculate_cost_helper({F, R}, MaxLap, ChangeTime, 1, F, [F]).

calculate_cost_helper({F, R}, MaxLap, ChangeTime, Lap, CurrentCost, Acc) when Lap =:= MaxLap ->
    Acc;
calculate_cost_helper({F, R}, MaxLap, ChangeTime, Lap, CurrentCost, Acc) when CurrentCost > ChangeTime + F ->
    Acc;
calculate_cost_helper({F, R}, MaxLap, ChangeTime, Lap, CurrentCost, Acc) ->
    NewCost = CurrentCost + F * math:pow(R, Lap);
    calculate_cost_helper({F, R}, MaxLap, ChangeTime, Lap + 1, NewCost, Acc ++ [NewCost]).

for(I, Start, End) when Start > End ->
    true;
for(I, Start, End) ->
    Fun = fun(I) -> true end,
    Fun(Start),
    for(I, Start + 1, End).

min(A, B) ->
    if A < B -> A;
    true -> B
    end.

infinity() ->
    1 bsl 60.