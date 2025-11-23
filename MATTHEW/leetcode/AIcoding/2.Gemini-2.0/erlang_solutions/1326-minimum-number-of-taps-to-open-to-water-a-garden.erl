-module(minimum_taps).
-export([min_taps/1]).

min_taps(Ranges) ->
  N = length(Ranges),
  MaxReach = lists:map(fun(I) ->
                           case lists:nth(I+1, Ranges) of
                             R ->
                               R + I
                           end
                         end, lists:seq(0, N-1)),
  min_taps_helper(MaxReach, 0, 0, 0).

min_taps_helper(MaxReach, CurrentReach, NextReach, Taps) ->
  N = length(MaxReach),
  if CurrentReach >= N then
    Taps
  else if CurrentReach >= NextReach andalso lists:nth(CurrentReach+1, MaxReach) =< CurrentReach then
    -1
  else
    NewNextReach = lists:foldl(fun(I, Acc) ->
                                 case I of
                                   I when I > CurrentReach andalso I =< NextReach ->
                                     max(Acc, lists:nth(I+1, MaxReach));
                                   _ ->
                                     Acc
                                 end
                               end, NextReach, lists:seq(0, N-1)),
    min_taps_helper(MaxReach, NewNextReach, NewNextReach, Taps + 1)
  end.