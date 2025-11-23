-module(shortest_distance).
-export([shortest_distance/3]).

shortest_distance(Words, Target, Start) ->
  N = length(Words),
  shortest_distance_helper(Words, Target, Start, 0, N).

shortest_distance_helper(Words, Target, Start, Acc, N) ->
  case lists:nth(Start + 1, Words) of
    Target ->
      Acc;
    _ ->
      Dist1 = find_forward(Words, Target, (Start + 1) rem N, 1, N),
      Dist2 = find_backward(Words, Target, (Start - 1 + N) rem N, 1, N),
      min(Dist1, Dist2)
  end.

find_forward(Words, Target, Index, Acc, N) ->
  case lists:nth(Index + 1, Words) of
    Target ->
      Acc;
    _ ->
      if Acc >= N div 2 then
        N
      else
        find_forward(Words, Target, (Index + 1) rem N, Acc + 1, N)
      end
  end.

find_backward(Words, Target, Index, Acc, N) ->
  case lists:nth(Index + 1, Words) of
    Target ->
      Acc;
    _ ->
      if Acc >= N div 2 then
        N
      else
        find_backward(Words, Target, (Index - 1 + N) rem N, Acc + 1, N)
      end
  end.