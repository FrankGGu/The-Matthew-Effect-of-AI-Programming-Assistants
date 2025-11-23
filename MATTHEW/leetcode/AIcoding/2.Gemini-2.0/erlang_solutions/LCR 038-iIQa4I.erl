-module(daily_temperatures).
-export([daily_temperatures/1]).

daily_temperatures(T) ->
  Len = length(T),
  daily_temperatures(T, Len, [], []).

daily_temperatures([], _, Acc, Result) ->
  lists:reverse(Result);
daily_temperatures([H|Rest], Len, Acc, Result) ->
  {Dist, NewAcc} = find_next_warmer(H, Rest, Acc, 0),
  daily_temperatures(Rest, Len, [{H, length(Rest)}|Acc], [Dist | Result]).

find_next_warmer(Temp, [], Acc, Dist) ->
  {0, Acc};
find_next_warmer(Temp, [NextTemp|Rest], Acc, Dist) ->
  case NextTemp > Temp of
    true ->
      {Dist + 1, Acc};
    false ->
      find_warmer_in_acc(Temp, Rest, Acc, Dist + 1)
  end.

find_warmer_in_acc(Temp, Rest, [], Dist) ->
  find_next_warmer(Temp, Rest, [], Dist);
find_warmer_in_acc(Temp, Rest, [{AccTemp, AccDist}|AccTail], Dist) ->
  case AccTemp > Temp of
    true ->
      {Dist + AccDist + 1, AccTail};
    false ->
      find_warmer_in_acc(Temp, Rest, AccTail, Dist)
  end.