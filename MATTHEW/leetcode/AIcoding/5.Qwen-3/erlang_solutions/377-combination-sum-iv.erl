-module(combo_sum_iv).
-export([combination_sum_4/2]).

combination_sum_4(Nums, Target) ->
    combination_sum_4(Nums, Target, #{}).

combination_sum_4(_, 0, Memo) ->
    1;
combination_sum_4(_, N, _) when N < 0 ->
    0;
combination_sum_4(Nums, N, Memo) ->
    case maps:find(N, Memo) of
        {ok, Val} ->
            Val;
        error ->
            Total = lists:sum([combination_sum_4(Nums, N - Num, maps:put(N, 0, Memo)) || Num <- Nums]),
            maps:put(N, Total, Memo),
            Total
    end.