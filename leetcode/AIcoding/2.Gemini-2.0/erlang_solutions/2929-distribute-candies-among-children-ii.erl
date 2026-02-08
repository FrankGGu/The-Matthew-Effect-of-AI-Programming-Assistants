-module(distributeCandies2).
-export([distributeCandies/3]).

distributeCandies(N, Limit, K) ->
  case K > N orelse K < 0 of
    true -> 0;
    false ->
      Good = max(0, min(N - K, Limit)),
      Bad = max(0, min(K, N - K - Limit -1)),
      Good + Bad + 1
  end.