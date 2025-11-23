-module(happy_number).
-export([is_happy/1]).

is_happy(N) ->
  is_happy(N, []).

is_happy(1, _) -> true;
is_happy(N, Seen) when lists:member(N, Seen) -> false;
is_happy(N, Seen) ->
  Next = sum_of_square_digits(N),
  is_happy(Next, [N | Seen]).

sum_of_square_digits(0) -> 0;
sum_of_square_digits(N) ->
  Digit = N rem 10,
  Digit * Digit + sum_of_square_digits(N div 10).