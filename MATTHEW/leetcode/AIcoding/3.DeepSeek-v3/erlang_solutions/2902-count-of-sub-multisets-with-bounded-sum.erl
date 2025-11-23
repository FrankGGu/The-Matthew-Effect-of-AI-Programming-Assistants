-module(solution).
-export([count_sub_multisets/3]).

count_sub_multisets(Nums, L, R) ->
    Counts = lists:foldl(fun(X, Acc) -> 
                            dict:update_counter(X, 1, Acc)
                         end, dict:new(), Nums),
    UniqueNums = dict:fetch_keys(Counts),
    DP0 = dict:from_list([{0, 1}]),
    DP = lists:foldl(fun(Num, DPAcc) ->
                        lists:foldl(fun(Sum, D) ->
                            case dict:find(Sum, D) of
                                {ok, Val} ->
                                    lists:foldl(fun(K, Acc) ->
                                        NewSum = Sum + K * Num,
                                        if 
                                            NewSum > R -> Acc;
                                            true ->
                                                dict:update_counter(NewSum, Val, Acc)
                                        end
                                    end, D, lists:seq(1, dict:fetch(Num, Counts)));
                                error -> D
                            end
                        end, DPAcc, lists:reverse(dict:fetch_keys(DPAcc)))
                     end, DP0, UniqueNums),
    lists:foldl(fun(Sum, Acc) ->
                    case dict:find(Sum, DP) of
                        {ok, Val} when Sum >= L, Sum =< R -> Acc + Val;
                        _ -> Acc
                    end
                end, 0, dict:fetch_keys(DP)).