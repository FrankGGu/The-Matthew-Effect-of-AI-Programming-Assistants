-module(minimum_lines).
-export([minimum_lines/1]).

minimum_lines(Points) ->
  length(minimum_lines_helper(lists:sort(Points), [])).

minimum_lines_helper([], Acc) ->
  lists:reverse(Acc);
minimum_lines_helper([_], Acc) ->
  lists:reverse(Acc);
minimum_lines_helper([P1, P2 | Rest], Acc) ->
  minimum_lines_helper(slope_filter([P1, P2 | Rest], P1, P2), [P1, P2] | Acc).

slope_filter([P1, P2, P3 | Rest], _, _) ->
  S1 = slope(P1, P2),
  S2 = slope(P2, P3),
  if S1 == S2 ->
    slope_filter([P1, P3 | Rest], P1, P3);
  true ->
    [P3 | Rest]
  end;
slope_filter([_P1, _P2], _, _) ->
  [].

slope([X1, Y1], [X2, Y2]) ->
  if X1 == X2 ->
    infinity;
  true ->
    (Y2 - Y1) / (X2 - X1)
  end.