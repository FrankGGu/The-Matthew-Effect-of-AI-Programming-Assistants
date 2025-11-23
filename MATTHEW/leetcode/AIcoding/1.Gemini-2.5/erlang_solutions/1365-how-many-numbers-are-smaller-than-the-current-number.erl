-module(solution).
-export([smaller_numbers_than_current/1]).

smaller_numbers_than_current(Nums) ->
    lists:map(fun(N) -> count_smaller(N, Nums) end, Nums).

count_smaller(Target, List) ->
    lists:foldl(fun(X, Acc) ->
        if X < Target -> Acc + 1;
           true -> Acc
        end
    end, 0, List).