-module(solution).
-export([canIWin/2]).

canIWin(MaxChoosableInteger, DesiredTotal) ->
    case (MaxChoosableInteger * (MaxChoosableInteger + 1)) div 2 < DesiredTotal of
        true -> false;
        false ->
            case DesiredTotal =< 0 of
                true -> true;
                false ->
                    Memo = maps:new(),
                    State = (1 bsl MaxChoosableInteger) - 1,
                    canWin(MaxChoosableInteger, DesiredTotal, State, Memo)
            end
    end.

canWin(Max, Total, State, Memo) ->
    case maps:get(State, Memo, undefined) of
        undefined ->
            Result = lists:any(fun(I) ->
                Mask = 1 bsl (I - 1),
                (State band Mask) =/= 0 andalso
                    (I >= Total orelse not canWin(Max, Total - I, State bxor Mask, Memo))
            end, lists:seq(1, Max)),
            {NewMemo, _} = maps:put(State, Result, Memo),
            Result;
        Result -> Result
    end.