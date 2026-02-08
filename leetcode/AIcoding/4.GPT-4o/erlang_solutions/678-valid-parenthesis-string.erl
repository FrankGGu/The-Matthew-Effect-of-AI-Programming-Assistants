-module(solution).
-export([checkValidString/1]).

checkValidString(S) ->
    check(S, 0, 0).

check([], Open, Star) ->
    Open =< Star;
check([H | T], Open, Star) ->
    case H of
        $'(' -> check(T, Open + 1, Star);
        $')' -> 
            if Open > 0 -> check(T, Open - 1, Star);
            true -> check(T, Open, Star - 1)
            end;
        $'*' -> check(T, Open, Star + 1)
    end.