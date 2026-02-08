-module(valid_perfect_square).
-export([is_perfect_square/1]).

is_perfect_square(Num) ->
  is_perfect_square(Num, 1, Num).

is_perfect_square(Num, Low, High) ->
  if Low > High ->
    false;
  true ->
    Mid = Low + (High - Low) div 2,
    Square = Mid * Mid,
    if Square == Num ->
      true;
    Square < Num ->
      is_perfect_square(Num, Mid + 1, High);
    true ->
      is_perfect_square(Num, Low, Mid - 1)
    end
  end.