-module(solution).
-export([count_routes/5]).

count_routes(Start, Finish, Fuel, Locations) ->
    count_routes(Start, Finish, Fuel, Locations, []).

count_routes(Start, Finish, Fuel, Locations, Visited) when Fuel < 0 -> 
    0;
count_routes(Start, Finish, Fuel, Locations, Visited) ->
    Visited1 = [Start | Visited],
    Count = if
        Start =:= Finish -> 1;
        true -> 0
    end,
    lists:foldl(fun(Next, Acc) ->
        if
            Next =:= Start orelse lists:member(Next, Visited) -> 
                Acc;
            true -> 
                FuelLeft = Fuel - lists:nth(Next + 1, Locations) - lists:nth(Start + 1, Locations),
                Acc + count_routes(Next, Finish, FuelLeft, Locations, Visited1)
        end
    end, Count, lists:seq(0, length(Locations) - 1)).