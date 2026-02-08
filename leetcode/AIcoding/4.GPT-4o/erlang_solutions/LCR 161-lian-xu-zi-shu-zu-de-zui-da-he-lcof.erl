-module(solution).
-export([max_sales_days/2]).

max_sales_days(Sales, Days) ->
    lists:foldl(fun({Sale, Day}, Acc) ->
        case lists:member(Day, Acc) of
            true -> Acc;
            false -> [Day | Acc]
        end
    end, [], lists:zip(Sales, lists:seq(1, length(Sales))) ++ lists:zip(Sales, lists:seq(1, Days))).