-module(sqrtx).
-export([my_sqrt/1]).

my_sqrt(X) ->
  my_sqrt(X, 0, X).

my_sqrt(X, Low, High) ->
  if
    Low > High ->
      High;
    true ->
      Mid = Low + (High - Low) div 2,
      Square = Mid * Mid,
      if
        Square =:= X ->
          Mid;
        Square < X ->
          my_sqrt(X, Mid + 1, High);
        true ->
          my_sqrt(X, Low, Mid - 1)
      end
  end.