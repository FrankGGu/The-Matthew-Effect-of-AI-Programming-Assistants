-module(multiply_strings).
-export([multiply/2]).

multiply(Num1, Num2) ->
  N1 = string:to_integer(Num1),
  N2 = string:to_integer(Num2),
  integer_to_list(N1 * N2).