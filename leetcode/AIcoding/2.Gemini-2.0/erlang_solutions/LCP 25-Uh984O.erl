-module(keyboard).
-export([keyboard/1]).

keyboard(arr) ->
  keyboard(arr, [], []).

keyboard([], Acc, Res) ->
  lists:reverse(Res);
keyboard([0 | Rest], Acc, Res) ->
  keyboard(Rest, [], Res ++ lists:duplicate(length(Acc), 0));
keyboard([N | Rest], Acc, Res) when N > 0 ->
  keyboard(Rest, Acc ++ [N], Res);
keyboard([_ | Rest], Acc, Res) ->
  keyboard(Rest, Acc, Res).