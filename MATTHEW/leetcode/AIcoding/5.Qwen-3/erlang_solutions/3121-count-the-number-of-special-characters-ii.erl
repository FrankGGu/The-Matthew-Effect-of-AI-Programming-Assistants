-module(solution).
-export([numberOfSpecialChars/1]).

numberOfSpecialChars(S) ->
    Count = lists:foldl(fun(Char, Acc) -> 
        case maps:get(Char, Acc, 0) of
            0 -> maps:put(Char, 1, Acc);
            1 -> maps:put(Char, 2, Acc);
            _ -> Acc
        end
    end, #{}, S),
    maps:fold(fun(_Char, 2, Acc) -> Acc + 1; (_, _, Acc) -> Acc end, 0, Count).