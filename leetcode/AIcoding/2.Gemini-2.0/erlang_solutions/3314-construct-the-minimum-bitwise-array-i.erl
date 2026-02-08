-module(minimum_bitwise_or).
-export([minimum_bitwise_or/1]).

minimum_bitwise_or(Arr) ->
  minimum_bitwise_or(Arr, 0, []).

minimum_bitwise_or([], Acc, Res) ->
  lists:reverse(Res);
minimum_bitwise_or([H|T], Acc, Res) ->
  NewAcc = Acc bor H,
  minimum_bitwise_or(T, NewAcc, [Acc|Res]).