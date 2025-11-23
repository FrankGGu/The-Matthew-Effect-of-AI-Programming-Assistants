-module(solution).
-export([manage_stock/2]).

manage_stock(N, Orders) ->
    lists:foldl(fun({C, Q}, Acc) -> 
        case Acc of
            [] -> [{C, Q}];
            [{C1, Q1} | Rest] when C1 =:= C -> [{C, Q1 + Q} | Rest];
            _ -> [{C, Q} | Acc]
        end
    end, [], Orders).