-module(solution).
-export([minimum_money/1]).

minimum_money(Transactions) ->
    lists:foldl(fun({Cost, Profit}, {Min, Total}) ->
        {min(Min, Total + Cost), Total + Profit}
    end, {0, 0}, Transactions).