-module(merge_operations).
-export([min_travel_time/1]).

min_travel_time(Locations) ->
    N = length(Locations),
    dp(Locations, N, 1, N, #{}).

dp(Locations, N, L, R, Cache) ->
    case maps:get({L, R}, Cache, undefined) of
        undefined ->
            case L =:= R of
                true ->
                    Result = 0;
                false ->
                    LeftValue = lists:nth(L, Locations),
                    RightValue = lists:nth(R, Locations),
                    MinCost = abs(LeftValue - RightValue),
                    case L + 1 =:= R of
                        true ->
                            Result = MinCost;
                        false ->
                            Result1 = dp(Locations, N, L + 1, R, Cache) + abs(lists:nth(L, Locations) - lists:nth(L + 1, Locations));
                            Result2 = dp(Locations, N, L, R - 1, Cache) + abs(lists:nth(R, Locations) - lists:nth(R - 1, Locations));
                            Result = min(Result1, Result2)
                    end
            end,
            NewCache = maps:put({L, R}, Result, Cache),
            NewCache, Result;
        Value ->
            Cache, Value
    end.