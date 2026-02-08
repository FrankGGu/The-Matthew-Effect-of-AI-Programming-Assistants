-module(solution).
-export([get_decimal_value/1]).

get_decimal_value(Head) ->
  lists:foldl(fun(Bit, Acc) -> Acc * 2 + Bit end, 0, to_list(Head)).

to_list(Head) ->
  to_list(Head, []).

to_list(null, Acc) ->
  lists:reverse(Acc);
to_list(#{val := V, next := Next}, Acc) ->
  to_list(Next, [V | Acc]).