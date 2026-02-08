-module(clumsy_factorial).
-export([clumsy/1]).

clumsy(N) ->
  clumsy(N, 0, 1, '*').

clumsy(0, Acc, _, _) ->
  Acc;
clumsy(N, Acc, Prev, Op) ->
  case Op of
    '*' ->
      clumsy(N - 1, Acc + (Prev * N), N, '/');
    '/' ->
      clumsy(N - 1, Acc - (Prev div N), N, '+');
    '+' ->
      clumsy(N - 1, Acc - N, N, '*');
    '-' ->
      clumsy(N - 1, Acc + N, N, '*')
  end.