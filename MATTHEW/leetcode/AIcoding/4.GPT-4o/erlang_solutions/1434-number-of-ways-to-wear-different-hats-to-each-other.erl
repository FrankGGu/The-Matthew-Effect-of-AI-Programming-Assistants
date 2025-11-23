-module(solution).
-export([number_of_ways/2]).

number_of_ways(Hats, People) ->
    N = length(People),
    HatMap = lists:foldl(fun({Hat, P}, Acc) ->
        lists:foldl(fun(X, Acc1) -> 
            case maps:get(X, Acc1, []) of
                [] -> maps:put(X, [Hat], Acc1);
                L -> maps:put(X, lists:append(L, [Hat]), Acc1)
            end
        end, Acc, P)
    end, maps:empty(), Hats),
    Ways = lists:foldl(fun({_, H}, Acc) -> 
        Acc * (length(H) + 1)
    end, 1, maps:to_list(HatMap)),
    Ways.