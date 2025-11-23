-module(daily_temperatures).
-export([dailyTemperatures/1]).

dailyTemperatures(T) ->
  dailyTemperatures(T, [], []).

dailyTemperatures([], Stack, Acc) ->
  lists:reverse(Acc);
dailyTemperatures([H | T], Stack, Acc) ->
  {NewStack, NewAcc} = process_temperature(H, Stack, Acc, length(T) + 1),
  dailyTemperatures(T, NewStack, NewAcc).

process_temperature(H, Stack, Acc, Index) ->
  process_temperature(H, Stack, Acc, Index, []).

process_temperature(H, [], Acc, Index, TempAcc) ->
  {[H, Index] | TempAcc, [0 | Acc]};
process_temperature(H, [[Temp, Idx] | Stack], Acc, Index, TempAcc) when Temp < H ->
  process_temperature(H, Stack, Acc, Index, [ [H, Index] | TempAcc]);
process_temperature(H, [[Temp, Idx] | Stack], Acc, Index, TempAcc) ->
  {[H, Index] | Stack, [Idx - Index | Acc]}.