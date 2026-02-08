-module(solution).
-export([findSumOfArrayProduct/2]).

findSumOfArrayProduct(N, M) ->
    MOD = 1000000007,

    dp_prev_init = lists:foldl(fun(Val, Acc) ->
                                   maps:put(Val, Val, Acc)
                               end, maps:new(), lists:seq(1, M)),

    ResultMap = lists:foldl(fun(_I, AccMap) ->
                                dp_curr = maps:new(),
                                lists:foldl(fun(CurrVal, CurrAccMap) ->
                                                PrevSum1 = case maps:find(CurrVal - 1, AccMap) of
                                                                {ok, S} -> S;
                                                                error -> 0
                                                            end,
                                                PrevSum2 = case maps:find(CurrVal, AccMap) of
                                                                {ok, S} -> S;
                                                                error -> 0
                                                            end,
                                                PrevSum3 = case maps:find(CurrVal + 1, AccMap) of
                                                                {ok, S} -> S;
                                                                error -> 0
                                                            end,

                                                TotalPrevSum = (PrevSum1 + PrevSum2 + PrevSum3) rem MOD,

                                                CurrentProductSum = (CurrVal * TotalPrevSum) rem MOD,
                                                maps:put(CurrVal, CurrentProductSum, CurrAccMap)
                                            end, dp_curr, lists:seq(1, M))
                            end, dp_prev_init, lists:seq(2, N)),

    lists:foldl(fun({_Key, Value}, Acc) ->
                    (Acc + Value) rem MOD
                end, 0, maps:to_list(ResultMap)).