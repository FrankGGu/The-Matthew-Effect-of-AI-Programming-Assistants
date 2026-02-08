-module(binary_gap).
-export([binary_gap/1]).

binary_gap(N) ->
  binary_gap(N, 0, 0, 0).

binary_gap(0, _, Max, _) ->
  Max;
binary_gap(N, Gap, Max, 1) ->
  binary_gap(N div 2, Gap + 1, Max, 1);
binary_gap(N, Gap, Max, 0) ->
  binary_gap(N div 2, Gap + 1, Max, 0);
binary_gap(N, Gap, Max, _) ->
  case N rem 2 of
    1 ->
      binary_gap(N div 2, 0, max(Max, Gap), 1);
    0 ->
      binary_gap(N div 2, Gap + 1, Max, 0)
  end.