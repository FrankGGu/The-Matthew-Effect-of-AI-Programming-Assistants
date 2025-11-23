-module(basic_calculator_ii).
-export([calculate/1]).

calculate(S) ->
  {Expr, []} = string_to_list(S) ++ [$ ],
  {Result, _} = eval(Expr, 0, 1),
  Result.

eval([$ ], Acc, Sign) ->
  {Acc, []};

eval([C | Rest], Acc, Sign) when C >= $0, C =< $9 ->
  {Num, NewRest} = get_number([C | Rest], []),
  eval(NewRest, Acc + Sign * Num, 1);

eval([$+, Space | Rest], Acc, Sign) when Space == $\s ->
  eval(Rest, Acc, 1);

eval([$*, Space | Rest], Acc, Sign) when Space == $\s ->
  {Num, NewRest} = get_number(Rest, []),
  eval(NewRest, Acc + Sign * Acc * Num - Acc, 1);

eval([$/, Space | Rest], Acc, Sign) when Space == $\s ->
  {Num, NewRest} = get_number(Rest, []),
  eval(NewRest, Acc + Sign * div(Acc, Num) - Acc, 1);

eval([$-, Space | Rest], Acc, Sign) when Space == $\s ->
  eval(Rest, Acc, -1);

eval([$+ | Rest], Acc, Sign) ->
  eval(Rest, Acc, 1);

eval([$- | Rest], Acc, Sign) ->
  eval(Rest, Acc, -1);

eval([$* | Rest], Acc, Sign) ->
  {Num, NewRest} = get_number(Rest, []),
  eval(NewRest, Acc + Sign * Acc * Num - Acc, 1);

eval([$/ | Rest], Acc, Sign) ->
  {Num, NewRest} = get_number(Rest, []),
  eval(NewRest, Acc + Sign * div(Acc, Num) - Acc, 1);

eval([Space | Rest], Acc, Sign) when Space == $\s ->
  eval(Rest, Acc, Sign).

get_number(Str, Acc) ->
  get_number_helper(Str, Acc, 0).

get_number_helper([C | Rest], Acc, Num) when C >= $0, C =< $9 ->
  get_number_helper(Rest, Acc * 10 + (C - $0), Num + 1);

get_number_helper(Rest, Acc, Num) ->
  {Acc, Rest}.