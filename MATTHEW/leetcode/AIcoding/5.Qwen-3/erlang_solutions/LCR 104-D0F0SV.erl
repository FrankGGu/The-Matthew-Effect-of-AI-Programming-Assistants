-module(combinationsum4).
-export([combination_sum_4/2]).

combination_sum_4(Nums, Target) ->
    dp(Target, Nums, #{}).

dp(0, _, _) ->
    1;
dp(N, Nums, Memo) when N < 0 ->
    0;
dp(N, Nums, Memo) ->
    case maps:find(N, Memo) of
        {ok, Val} ->
            Val;
        error ->
            Total = lists:sum([dp(N - Num, Nums, Memo) || Num <- Nums]),
            maps:put(N, Total, Memo),
            Total
    end.