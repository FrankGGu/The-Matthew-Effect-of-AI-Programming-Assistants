-module(solution).
-export([checkValidString/1]).

checkValidString(S) ->
    check(S, 0, 0).

check([], Open, Star) when Open =< Star -> true;
check([H | T], Open, Star) ->
    case H of
        $* -> check(T, Open, Star + 1);
        $) -> 
            if Open > 0 -> 
                check(T, Open - 1, Star);
            true -> 
                if Star > 0 -> 
                    check(T, Open, Star - 1);
                true -> 
                    false
                end
            end;
        $ ( -> check(T, Open + 1, Star);
        _ -> check(T, Open, Star)
    end.