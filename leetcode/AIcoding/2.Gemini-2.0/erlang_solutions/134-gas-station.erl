-module(gas_station).
-export([canCompleteCircuit/1]).

canCompleteCircuit(gas) ->
  canCompleteCircuit(gas, 0, 0, 0).

canCompleteCircuit([], _, Total, Start) ->
  case Total >= 0 of
    true -> Start;
    false -> -1
  end;

canCompleteCircuit([G - C | T], Current, Total, Start) ->
  NewCurrent = Current + G - C,
  NewTotal = Total + G - C,
  case NewCurrent < 0 of
    true -> canCompleteCircuit(T, 0, NewTotal, length(T) + length([G - C]));
    false -> canCompleteCircuit(T, NewCurrent, NewTotal, Start)
  end.