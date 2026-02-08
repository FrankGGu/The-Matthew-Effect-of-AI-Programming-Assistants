-module(date_to_binary).
-export([solve/1]).

solve(Date) ->
  [Year, Month, Day] = string:split(Date, "-", all),
  Y = list_to_integer(Year),
  M = list_to_integer(Month),
  D = list_to_integer(Day),
  [integer_to_binary(Y), integer_to_binary(M), integer_to_binary(D)].