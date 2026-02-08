-module(basic_calculator).
-export([calculate/1]).

calculate(S) ->
  {Result, _} = calculate_helper(S, 0, 1),
  Result.

calculate_helper([], Acc, Sign) ->
  {Acc, []};
calculate_helper([$+|Rest], Acc, Sign) ->
  calculate_helper(Rest, Acc, 1);
calculate_helper([$-|Rest], Acc, Sign) ->
  calculate_helper(Rest, Acc, -1);
calculate_helper([$(|Rest], Acc, Sign) ->
  {Result, Remaining} = calculate_helper(Rest, 0, 1),
  calculate_helper(Remaining, Acc + Sign * Result, 1);
calculate_helper([$)|Rest], Acc, Sign) ->
  {Acc, Rest};
calculate_helper([H|Rest], Acc, Sign) when H >= $0, H <= $9 ->
  {Num, Remaining} = read_number([H|Rest], []),
  calculate_helper(Remaining, Acc + Sign * Num, 1);
calculate_helper([_|Rest], Acc, Sign) ->
  calculate_helper(Rest, Acc, Sign).

read_number(S, Acc) ->
  read_number_helper(S, Acc, 0).

read_number_helper([], Acc, Num) ->
  {Num, []};
read_number_helper([H|Rest], Acc, Num) when H >= $0, H <= $9 ->
  NewNum = Num * 10 + (H - $0),
  read_number_helper(Rest, Acc, NewNum);
read_number_helper(S, Acc, Num) ->
  {Num, S}.