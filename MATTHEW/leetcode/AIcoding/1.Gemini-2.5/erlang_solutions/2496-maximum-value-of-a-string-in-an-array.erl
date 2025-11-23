-module(solution).
-export([maximumValue/1]).

maximumValue(Strs) ->
    lists:foldl(fun(S, MaxAcc) ->
        CurrentValue = calculate_value(S),
        max(CurrentValue, MaxAcc)
    end, 0, Strs).

calculate_value(S) ->
    case string:all(S, fun(C) -> C >= $0 andalso C =< $9 end) of
        true ->
            list_to_integer(S);
        false ->
            length(S)
    end.