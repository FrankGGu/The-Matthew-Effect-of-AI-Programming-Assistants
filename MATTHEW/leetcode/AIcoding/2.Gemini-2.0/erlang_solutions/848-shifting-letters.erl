-module(shifting_letters).
-export([shifting_letters/2]).

shifting_letters(S, Shifts) ->
  shifting_letters(S, Shifts, 0, []).

shifting_letters([], [], Acc, Result) ->
  lists:reverse(Result);
shifting_letters(S, Shifts, Acc, Result) ->
  {Char, RestS} = lists:split(1, S),
  {Shift, RestShifts} = lists:split(1, Shifts),
  NewAcc = (Acc + hd(Shift)) rem 26,
  NewChar = shift_char(hd(Char), NewAcc),
  shifting_letters(RestS, RestShifts, NewAcc, [NewChar | Result]).

shift_char(Char, Shift) ->
  Base = $a,
  NewCode = ((Char - Base + Shift) rem 26) + Base,
  NewCode.