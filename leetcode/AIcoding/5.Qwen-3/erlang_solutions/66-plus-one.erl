-module(plus_one).
-export([plus_one/1]).

plus_one(Digits) ->
    plus_one(Digits, []).

plus_one([], Carry) ->
    case Carry of
        0 -> [];
        _ -> [Carry]
    end;

plus_one([D | Digits], Carry) ->
    NewVal = D + Carry,
    NewCarry = NewVal div 10,
    [NewVal rem 10 | plus_one(Digits, NewCarry)].