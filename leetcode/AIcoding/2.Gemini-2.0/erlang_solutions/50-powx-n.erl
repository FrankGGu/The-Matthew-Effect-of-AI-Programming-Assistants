-module(pow).
-export([myPow/2]).

myPow(X, N) ->
  myPow_helper(X, N, 1.0).

myPow_helper(_, 0, Acc) ->
  Acc;
myPow_helper(X, N, Acc) when N > 0 ->
  if N rem 2 == 0 ->
    myPow_helper(X * X, N div 2, Acc);
  true ->
    myPow_helper(X, N - 1, Acc * X)
  end;
myPow_helper(X, N, Acc) ->
  myPow_helper(1.0 / X, -N, Acc).