-module(solution).
-export([max_profit/2]).

max_profit(K, Prices) ->
    max_profit(K, Prices, []).

max_profit(_K, [], _Trans) ->
    0;
max_profit(0, _, _) ->
    0;
max_profit(K, [H | T], Trans) ->
    Max = lists:max([lists:foldl(fun({Buy, Sell}, Acc) -> max(Acc, Sell - Buy) end, 0, Trans) | [max_profit(K, T, Trans)]]),
    NewTrans = [{H, H} | Trans],
    case K of
        1 -> Max;
        _ -> max(Max, max_profit(K-1, T, NewTrans))
    end.