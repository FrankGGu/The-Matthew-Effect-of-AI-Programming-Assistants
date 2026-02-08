-module(solution).
-export([minimum_time/2]).

minimum_time(S, K) ->
  Len = length(S),
  minimum_time_helper(S, K, 1, Len).

minimum_time_helper(S, K, Count, Len) ->
  Sub = lists:sublist(S, K + 1, Len - K),
  case lists:prefix(Sub, S) of
    true ->
      Count;
    false ->
      minimum_time_helper(S, K, Count + 1, Len - K)
  end.