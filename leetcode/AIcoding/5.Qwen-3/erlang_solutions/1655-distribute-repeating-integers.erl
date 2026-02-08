-module(distribute_repeating_integers).
-export([canDivide/1]).

canDivide(Nums) ->
    Count = lists:foldl(fun(N, Acc) -> dict:update_counter(N, 1, Acc) end, dict:new(), Nums),
    Keys = dict:keys(Count),
    lists:all(fun(K) -> 
        case dict:fetch(K, Count) of
            V when V >= 2 -> true;
            _ -> false
        end
    end, Keys).

test() ->
    canDivide([5,2,3,4,5,6]) == true,
    canDivide([1,1,2]) == true,
    canDivide([1,2,3,4]) == false,
    canDivide([2,2,2,2]) == true,
    canDivide([3,3,3,3,3]) == true.