-module(pow).
-export([my_pow/2]).

my_pow(X, N) ->
  my_pow(X, N, 1.0).

my_pow(X, 0, Acc) ->
  Acc;
my_pow(X, N, Acc) when N > 0 ->
  if N rem 2 == 0 ->
    my_pow(X * X, N div 2, Acc);
  true ->
    my_pow(X, N - 1, Acc * X)
  end;
my_pow(X, N, Acc) when N < 0 ->
  my_pow(1 / X, -N, Acc).