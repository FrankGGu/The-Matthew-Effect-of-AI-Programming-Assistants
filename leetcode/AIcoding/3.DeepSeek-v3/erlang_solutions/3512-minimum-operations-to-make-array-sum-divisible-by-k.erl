-module(solution).
-export([min_operations/2]).

min_operations(Nums, K) ->
    Sum = lists:sum(Nums),
    Rem = Sum rem K,
    if 
        Rem == 0 -> 0;
        true ->
            Counts = lists:foldl(fun(Num, Acc) ->
                R = Num rem K,
                maps:update_with(R, fun(V) -> V + 1 end, 1, Acc)
            end, maps:new(), Nums),
            find_min_operations(Rem, K, Counts, 0)
    end.

find_min_operations(Rem, K, Counts, Steps) ->
    case maps:get(Rem, Counts, 0) > 0 of
        true -> Steps;
        false ->
            NewRem = (Rem - 1 + K) rem K,
            find_min_operations(NewRem, K, Counts, Steps + 1)
    end.