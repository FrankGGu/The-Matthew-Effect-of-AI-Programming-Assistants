-module(harshad_number).
-export([is_harshad_number/1]).

is_harshad_number(N) ->
  is_harshad_number(N, N).

is_harshad_number(N, Original) when N < 10 ->
  (Original rem N) == 0;
is_harshad_number(N, Original) ->
  Digit = N rem 10,
  is_harshad_number(N div 10, Original, Digit).

is_harshad_number(0, Original, Sum) ->
  (Original rem Sum) == 0;
is_harshad_number(N, Original, Sum) ->
  Digit = N rem 10,
  is_harshad_number(N div 10, Original, Sum + Digit).