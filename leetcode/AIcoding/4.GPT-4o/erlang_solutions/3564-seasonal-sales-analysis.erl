-module(solution).
-export([seasonal_sales_analysis/1]).

seasonal_sales_analysis(S) ->
    lists:map(fun(X) -> 
        {X, lists:sum(lists:map(fun(Y) -> lists:nth(X, Y) end, S))}
    end, lists:seq(1, length(hd(S)))).