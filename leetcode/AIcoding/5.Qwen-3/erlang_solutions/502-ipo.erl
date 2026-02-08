-module(ipo).
-export([find_max_profit/2]).

find_max_profit(S, K) ->
    lists:foldl(fun({Profit, Capital}, {MaxProfit, Projects}) ->
        case length(Projects) < K of
            true ->
                Sorted = lists:sort([{Capital, Profit} | Projects]),
                {MaxProfit + hd(Sorted), tl(Sorted)};
            false ->
                {MaxProfit, Projects}
        end
    end, {0, []}, S).