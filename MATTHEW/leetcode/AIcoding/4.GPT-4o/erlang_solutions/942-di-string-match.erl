-module(solution).
-export([di_string_match/1]).

di_string_match(S) ->
    N = string:length(S),
    L = lists:seq(0, N),
    I = lists:foldl(fun(X, Acc) -> 
        case string:substr(S, X + 1, 1) of
            "I" -> [hd(Acc) + 1 | tl(Acc)];
            "D" -> [last(Acc) - 1 | Acc]
        end
    end, [0], lists:seq(0, N - 1)),
    lists:reverse(I).