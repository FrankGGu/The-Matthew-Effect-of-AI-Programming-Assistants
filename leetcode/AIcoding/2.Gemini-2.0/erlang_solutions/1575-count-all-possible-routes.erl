-module(count_routes).
-export([count_routes/3]).

count_routes(Locations, Start, Finish, Fuel) ->
    memo(Locations, Start, Finish, Fuel, {}).

memo(Locations, Start, Finish, Fuel, Memo) ->
    case maps:get({Start, Fuel}, Memo, undefined) of
        undefined ->
            Result = count_routes_helper(Locations, Start, Finish, Fuel, Memo);
            maps:put({Start, Fuel}, Result, Memo),
            Result;
        Value ->
            Value
    end.

count_routes_helper(Locations, Start, Finish, Fuel, Memo) ->
    if Fuel < 0 ->
        0;
    true ->
        Sum = 
            (if Start == Finish -> 1 else 0 end) +
            lists:sum([
                begin
                    Distance = abs(lists:nth(Start + 1, Locations) - lists:nth(I + 1, Locations)),
                    if I /= Start andalso Fuel >= Distance ->
                        memo(Locations, I, Finish, Fuel - Distance, Memo)
                    else
                        0
                    end
                end
            || I <- lists:seq(0, length(Locations) - 1)]),
        Sum rem 1000000007
    end.