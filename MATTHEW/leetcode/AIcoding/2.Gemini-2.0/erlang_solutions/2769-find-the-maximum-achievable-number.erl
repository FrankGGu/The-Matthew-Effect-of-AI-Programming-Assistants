-module(find_maximum_achievable_number).
-export([maximum_achievable_number/2]).

maximum_achievable_number(Num, T) ->
  Num + 2 * T.