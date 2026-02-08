-module(solution).
-export([are_digits_equal/1]).

are_digits_equal(S) ->
    case string:to_integer(S) of
        {ok, N} -> 
            Digits = lists:map(fun(X) -> (N div 10) rem 10 end, lists:seq(1, 10)),
            lists:all(fun(D) -> D =:= hd(Digits) end, Digits);
        _ -> false
    end.