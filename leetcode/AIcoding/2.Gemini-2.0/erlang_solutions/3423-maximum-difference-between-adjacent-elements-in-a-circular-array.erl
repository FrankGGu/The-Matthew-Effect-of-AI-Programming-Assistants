-module(max_diff_circular).
-export([solve/1]).

solve(A) ->
  N = length(A),
  case N of
    0 -> 0;
    1 -> 0;
    _ ->
      MaxDiff = lists:foldl(fun(I, Acc) ->
                                  Curr = lists:nth(I, A),
                                  NextIndex = (I rem N) + 1,
                                  Next = lists:nth(NextIndex, A),
                                  Diff = abs(Curr - Next),
                                  max(Acc, Diff)
                              end, 0, lists:seq(1, N)).
      MaxDiff
  end.