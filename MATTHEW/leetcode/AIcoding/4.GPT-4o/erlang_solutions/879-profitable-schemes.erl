-module(solution).
-export([profitableSchemes/5]).

profitableSchemes(N, minProfit, group, profit) ->
    M = length(group),
    Profitable = lists:duplicate(N + 1, lists:duplicate(minProfit + 1, 0)),
    Profitable1 = lists:duplicate(N + 1, lists:duplicate(minProfit + 1, 0)),
    Profitable2 = lists:duplicate(N + 1, lists:duplicate(minProfit + 1, 0)),
    Profitable3 = lists:duplicate(N + 1, lists:duplicate(minProfit + 1, 0)),
    Profitable4 = lists:duplicate(N + 1, lists:duplicate(minProfit + 1, 0)),
    Profitable5 = lists:duplicate(N + 1, lists:duplicate(minProfit + 1, 0)),
    Profitable6 = lists:duplicate(N + 1, lists:duplicate(minProfit + 1, 0)),
    Profitable7 = lists:duplicate(N + 1, lists:duplicate(minProfit + 1, 0)),
    Profitable8 = lists:duplicate(N + 1, lists:duplicate(minProfit + 1, 0)),
    lists:foldl(fun({G, P}, Acc) -> 
        lists:foldl(fun(N, Acc1) -> 
            lists:foldl(fun(Profit1, Acc2) ->
                if 
                    N >= G -> 
                        Profit2 = min(Profit1 + P, minProfit),
                        Acc3 = Acc2 + lists:nth(N - G + 1, lists:nth(Profit2 + 1, Acc1))
                    ; 
                        Acc2 
                end
            end, Acc1, lists:seq(0, minProfit))
        end, Acc, lists:seq(0, N))
    end, Profitable, lists:zip(group, profit)),
    lists:foldl(fun(Profit1, Acc) -> 
        lists:nth(Profit1 + 1, Acc)
    end, 0, lists:seq(0, minProfit)).