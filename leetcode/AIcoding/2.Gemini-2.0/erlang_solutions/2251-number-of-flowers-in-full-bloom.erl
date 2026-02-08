-module(flowers).
-export([full_bloom/2]).

full_bloom(Flowers, People) ->
  Starts = lists:sort([S || [S,_] <- Flowers]),
  Ends = lists:sort([E+1 || [_,E] <- Flowers]),
  [blooming(P, Starts, Ends) || P <- People].

blooming(P, Starts, Ends) ->
  start_count(P, Starts) - end_count(P, Ends).

start_count(P, Starts) ->
  binary_search_right(P, Starts, 0, length(Starts) - 1).

end_count(P, Ends) ->
  binary_search_right(P, Ends, 0, length(Ends) - 1).

binary_search_right(_P, [], _Low, _High) ->
  0;
binary_search_right(P, List, Low, High) ->
  if Low > High ->
    Low;
  true ->
    Mid = (Low + High + 1) div 2,
    case lists:nth(Mid, List) =< P of
      true ->
        binary_search_right(P, List, Mid, High);
      false ->
        binary_search_right(P, List, Low, Mid - 1)
    end
  end.