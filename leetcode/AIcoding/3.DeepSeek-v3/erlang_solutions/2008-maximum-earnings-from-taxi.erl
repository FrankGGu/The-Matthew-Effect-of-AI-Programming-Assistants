-module(solution).
-export([max_taxi_earnings/2]).

max_taxi_earnings(N, Rides) ->
    SortedRides = lists:sort(fun([A, _], [B, _]) -> A =< B end, Rides),
    DP = array:new(N + 1, {default, 0}),
    {_, Max} = process_rides(SortedRides, 0, DP, 0),
    Max.

process_rides([], _, DP, Max) ->
    {DP, Max};
process_rides([[Start, End, Tip] | Rest], Index, DP, Max) ->
    DP1 = case Index < Start of
              true ->
                  process_rides([[Start, End, Tip] | Rest], Start, DP, Max);
              false ->
                  {DP, Max}
          end,
    {DP2, CurrentMax} = DP1,
    Earnings = End - Start + Tip,
    PrevEarnings = array:get(Start, DP2),
    NewEarnings = PrevEarnings + Earnings,
    CurrentDP = array:set(End, max(array:get(End, DP2), NewEarnings), DP2),
    NewMax = max(NewEarnings, CurrentMax),
    process_rides(Rest, Index, CurrentDP, NewMax).