-module(solution).
-export([minimizedMaximum/2]).

minimizedMaximum(N, A) ->
    Min = 1,
    Max = lists:max(A),
    min_max_binary_search(Min, Max, N, A).

min_max_binary_search(Min, Max, N, A) ->
    case Min < Max of
        true ->
            Mid = (Min + Max) div 2,
            if
                sum_products(Mid, A) > N ->
                    min_max_binary_search(Mid + 1, Max, N, A);
                true ->
                    min_max_binary_search(Min, Mid, N, A)
            end;
        false ->
            Min
    end.

sum_products(X, A) ->
    lists:sum([ceil(P / X) || P <- A]).