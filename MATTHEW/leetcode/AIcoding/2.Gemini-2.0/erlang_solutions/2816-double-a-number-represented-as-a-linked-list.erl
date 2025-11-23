-module(double_linked_list).
-export([doubleIt/1]).

doubleIt(List) ->
    doubleIt(List, 0, []).

doubleIt([], Carry, Acc) ->
    case Carry of
        0 -> lists:reverse(Acc);
        _ -> lists:reverse([Carry | Acc])
    end;
doubleIt([H|T], Carry, Acc) ->
    Sum = H * 2 + Carry,
    NewCarry = Sum div 10,
    NewVal = Sum rem 10,
    doubleIt(T, NewCarry, [NewVal | Acc]).