-module(max_earnings_from_taxi).
-export([maxTaxiEarnings/1]).

maxTaxiEarnings(Trips) ->
    Sorted = lists:sort(fun({A, B, C}, {D, E, F}) -> A < D end, Trips),
    DP = maps:new(),
    max_taxi_earnings(Sorted, 0, DP).

max_taxi_earnings([], _Index, _DP) ->
    0;

max_taxi_earnings([Trip | Rest], Index, DP) ->
    {Start, End, Earn} = Trip,
    NextIndex = find_next_index(Rest, Start),
    Include = Earn + max_taxi_earnings(Rest, NextIndex, DP),
    Exclude = max_taxi_earnings(Rest, Index + 1, DP),
    maps:get(Index, DP, 0) = max(Include, Exclude),
    max(Include, Exclude).

find_next_index([], _Start) ->
    0;

find_next_index([Trip | Rest], Start) ->
    {S, _, _} = Trip,
    if
        S >= Start ->
            0;
        true ->
            find_next_index(Rest, Start)
    end.