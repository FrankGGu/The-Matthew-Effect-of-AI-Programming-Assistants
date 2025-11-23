-module(burst_balloons).
-export([find_min_arrow_shots/1]).

find_min_arrow_shots(Points) ->
  find_min_arrow_shots(lists:sort(Points, fun({A1, _}, {A2, _}) -> A1 < A2 end), 0, undefined).

find_min_arrow_shots([], Arrows, _) ->
  Arrows;
find_min_arrow_shots([ {Start, End} | Rest], Arrows, undefined) ->
  find_min_arrow_shots(Rest, Arrows + 1, {Start, End});
find_min_arrow_shots([ {Start, End} | Rest], Arrows, {CurrentStart, CurrentEnd}) ->
  if
    Start > CurrentEnd ->
      find_min_arrow_shots(Rest, Arrows + 1, {Start, End});
    true ->
      NewEnd = min(End, CurrentEnd),
      find_min_arrow_shots(Rest, Arrows, {CurrentStart, NewEnd})
  end.