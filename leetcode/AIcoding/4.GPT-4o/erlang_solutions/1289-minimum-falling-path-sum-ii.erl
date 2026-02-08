-module(solution).
-export([min_falling_path_sum/1]).

min_falling_path_sum(Matrix) ->
    N = length(Matrix),
    lists:foldl(fun(Row, Acc) -> 
        lists:map(fun({Val, Index}) -> 
            {Val + find_min(Acc, Index), Index} 
        end, lists:zip(Row, lists:seq(0, N-1))) 
    end, lists:duplicate(N, 0), lists:reverse(Matrix)
    ) |> lists:map(fun({Sum, _}) -> Sum end) |> lists:min().

find_min(Acc, Index) ->
    Acc1 = lists:map(fun({Val, I}) -> 
        if 
            I =/= Index -> Val; 
            true -> infinity 
        end 
    end, Acc),
    lists:min(Acc1).