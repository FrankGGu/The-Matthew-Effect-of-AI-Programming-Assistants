-module(orderly_queue).
-export([orderly_queue/2]).

orderly_queue(S, K) ->
  case K of
    1 ->
      Len = length(S),
      lists:foldl(fun(I, Acc) ->
                      NewS = lists:sublist(S, I, Len - I + 1) ++ lists:sublist(S, 1, I - 1),
                      min_string(Acc, NewS)
                  end, S, lists:seq(2, length(S)));
    _ ->
      lists:sort(S)
  end.

min_string(S1, S2) ->
  case S1 < S2 of
    true -> S1;
    false -> S2
  end.