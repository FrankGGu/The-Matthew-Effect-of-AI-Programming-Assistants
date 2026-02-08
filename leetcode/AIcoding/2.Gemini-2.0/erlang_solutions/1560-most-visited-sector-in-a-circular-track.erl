-module(most_visited).
-export([most_visited/2]).

most_visited(N, Rounds) ->
  case length(Rounds) of
    0 -> lists:seq(1, N);
    _ ->
      Start = hd(Rounds),
      End = lists:last(Rounds),
      if Start =< End ->
        lists:seq(Start, End)
      else
        lists:seq(1, End) ++ lists:seq(Start, N)
      end
  end.