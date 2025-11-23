-module(solution).
-export([countRoutes/4]).

-define(MOD, 1000000007).
-define(MEMO_TABLE, routes_memo).

countRoutes(LocationsList, Start, Target, Fuel) ->
    Locations = array:from_list(LocationsList),
    N = array:size(Locations),

    catch ets:delete(?MEMO_TABLE),
    ets:new(?MEMO_TABLE, [set, public]),

    Result = solve(Locations, N, Target, Fuel, Start),

    ets:delete(?MEMO_TABLE),
    Result.

solve(Locations, N, Target, CurrentFuel, CurrentCity) ->
    case ets:lookup(?MEMO_TABLE, {CurrentCity, CurrentFuel}) of
        [{_, Result}] ->
            Result;
        [] ->
            Count = 
                if CurrentCity == Target -> 1;
                   true -> 0
                end,

            NewCount = lists:foldl(
                fun(NextCity, Acc) ->
                    if NextCity == CurrentCity ->
                        Acc;
                    true ->
                        LocCurrent = array:get(CurrentCity, Locations), 
                        LocNext = array:get(NextCity, Locations),
                        FuelCost = abs(LocCurrent - LocNext),

                        if CurrentFuel >= FuelCost ->
                            (Acc + solve(Locations, N, Target, CurrentFuel - FuelCost, NextCity)) rem ?MOD;
                        true ->
                            Acc
                        end
                    end
                end,
                Count,
                lists:seq(0, N - 1)
            ),

            ets:insert(?MEMO_TABLE, {{CurrentCity, CurrentFuel}, NewCount}),
            NewCount
    end.