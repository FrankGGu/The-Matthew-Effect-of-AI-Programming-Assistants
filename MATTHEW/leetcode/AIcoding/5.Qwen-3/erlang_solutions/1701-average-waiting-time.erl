-module(average_waiting_time).
-export([averageWaitingTime/1]).

averageWaitingTime(Restaurants) ->
    averageWaitingTime(Restaurants, 0, 0).

averageWaitingTime([], _CurrentTime, TotalWait) ->
    TotalWait / length(Restaurants);
averageWaitingTime([{Id, Arrive, Duration} | Rest], CurrentTime, TotalWait) ->
    StartTime = max(Arrive, CurrentTime),
    EndTime = StartTime + Duration,
    Wait = EndTime - Arrive,
    averageWaitingTime(Rest, EndTime, TotalWait + Wait).