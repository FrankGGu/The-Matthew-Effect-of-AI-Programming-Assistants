-module(solution).
-export([number_game/1]).

number_game(Nums) ->
    N = length(Nums),
    List = lists:seq(0, N-1),
    Sorted = lists:sort(fun(I) -> element(I+1, Nums) end, List),
    Result = lists:foldl(fun(I, Acc) -> 
        if I == 0 -> [element(I+1, Nums)];
           true -> [element(I+1, Nums) | Acc]
        end
    end, [], Sorted),
    lists:reverse(Result).