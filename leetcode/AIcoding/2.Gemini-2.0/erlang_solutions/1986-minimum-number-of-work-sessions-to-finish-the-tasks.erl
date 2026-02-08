-module(minimum_sessions).
-export([minSessions/2]).

minSessions(Tasks, SessionTime) ->
  N = length(Tasks),
  PowersetSize = 1 bsl N,
  min_sessions(Tasks, SessionTime, 0, PowersetSize, infinity).

min_sessions(Tasks, SessionTime, Mask, PowersetSize, MinSessions) when Mask >= PowersetSize ->
  MinSessions;
min_sessions(Tasks, SessionTime, Mask, PowersetSize, MinSessions) ->
  lists:foldl(
    fun(NextMask, AccMinSessions) ->
      if NextMask > Mask andalso (Mask band NextMask) == 0  then
        Subset = [Tasks !! I || I <- lists:seq(0, length(Tasks) - 1), (NextMask band (1 bsl I)) > 0],
        Sum = lists:sum(Subset),
        if Sum =< SessionTime then
          RemainingMask = Mask bor NextMask,
          if RemainingMask == (PowersetSize - 1) then
            min(AccMinSessions, 1)
          else
            NextMinSessions = min_sessions(Tasks, SessionTime, RemainingMask, PowersetSize, infinity),
            min(AccMinSessions, NextMinSessions + 1)
          end
        else
          AccMinSessions
        end
      else
        AccMinSessions
      end
    end,
    MinSessions,
    lists:seq(0, PowersetSize - 1)
  ).

min(A, B) ->
  if A < B then A else B end.

infinity() -> 10000.