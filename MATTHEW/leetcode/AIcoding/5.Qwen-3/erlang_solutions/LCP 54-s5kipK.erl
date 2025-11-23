-module(siege).
-export([renewal/1]).

renewal(S) ->
    F = fun(C, Acc) -> 
        case Acc of
            [] -> [C];
            [H | T] when H == C -> [H | T];
            _ -> [C]
        end
    end,
    lists:foldl(F, [], S).