-module(best_time_to_buy_sell_stock_iv).
-export([max_profit/2]).

max_profit(K, Prices) ->
    max_profit(K, Prices, length(Prices)).

max_profit(K, Prices, N) ->
    if
        N =< 1 or K =< 0 ->
            0;
        true ->
            DP = array:new([{size, {K + 1, N}}, {default, 0}]),
            for(K_Index = 1, K_Index =< K, K_Index + 1,
                fun(K_Index) ->
                    Buy = -hd(Prices),
                    for(N_Index = 1, N_Index < N, N_Index + 1,
                        fun(N_Index) ->
                            Price = lists:nth(N_Index, Prices),
                            array:set({K_Index, N_Index}, max(array:get({K_Index, N_Index - 1}, DP), Price + Buy), DP),
                            Buy = max(Buy, array:get({K_Index - 1, N_Index - 1}, DP) - Price)
                        end)
                end),
            array:get({K, N - 1}, DP)
    end.