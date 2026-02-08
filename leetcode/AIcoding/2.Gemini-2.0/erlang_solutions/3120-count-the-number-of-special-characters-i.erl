-module(special_characters).
-export([solve/1]).

solve(S) ->
  solve(S, 0).

solve([], Count) ->
  Count;
solve([H|T], Count) ->
  case H >= 33 andalso H =< 47 orelse
       H >= 58 andalso H =< 64 orelse
       H >= 91 andalso H =< 96 orelse
       H >= 123 andalso H =< 126 of
    true ->
      solve(T, Count + 1);
    false ->
      solve(T, Count)
  end.