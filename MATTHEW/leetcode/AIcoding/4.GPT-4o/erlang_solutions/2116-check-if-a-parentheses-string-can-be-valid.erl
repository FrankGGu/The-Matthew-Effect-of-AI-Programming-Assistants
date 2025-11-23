-module(solution).
-export([checkValidString/1]).

checkValidString(S) ->
    check(S, 0, 0).

check([], OpenCount, StarCount) ->
    OpenCount =< StarCount;
check([H | T], OpenCount, StarCount) ->
    case H of
        $'(' -> check(T, OpenCount + 1, StarCount);
        $')' -> 
            if OpenCount > 0 -> 
                check(T, OpenCount - 1, StarCount);
            true -> 
                check(T, OpenCount, StarCount - 1)
            end;
        $'*' -> 
            check(T, OpenCount, StarCount + 1) orelse 
            check(T, OpenCount + 1, StarCount) orelse 
            check(T, OpenCount, StarCount - 1)
    end.