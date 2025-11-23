-module(solution).
-export([largest_integer/2]).

largest_integer(Digits, Target) ->
    largest_integer(Digits, Target, []).

largest_integer(_, Target, Acc) when Target < 0 -> 
    "" ;
largest_integer([], Target, Acc) -> 
    lists:reverse(Acc) ;
largest_integer(Digits, Target, Acc) ->
    MaxDigit = lists:max(Digits),
    NewAcc = [MaxDigit | Acc],
    NewDigits = lists:delete(MaxDigit, Digits),
    largest_integer(NewDigits, Target - MaxDigit, NewAcc).