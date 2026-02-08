-module(solution).
-export([arraySign/1]).

arraySign(Array) ->
    ProductSign = lists:foldl(fun(X, Acc) -> 
        case X of
            0 -> 0;
            _ when X < 0 -> -Acc;
            _ -> Acc
        end
    end, 1, Array),
    ProductSign.