-module(maximum69Number).
-export([maximum69Number/1]).

maximum69Number(Num) ->
  maximum69Number(integer_to_list(Num), []).

maximum69Number([], Acc) ->
  list_to_integer(lists:reverse(Acc));
maximum69Number([$6 | Rest], Acc) ->
  lists:reverse(Acc) ++ [$9] ++ Rest_str = lists:flatten([lists:reverse(Acc), [$9], Rest]),
  list_to_integer(Rest_str);
maximum69Number([H | Rest], Acc) ->
  maximum69Number(Rest, [H | Acc]).