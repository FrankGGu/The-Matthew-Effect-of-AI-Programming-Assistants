-module(solution).
-export([min_cost/2]).

min_cost(Costs, K) ->
    N = length(Costs),
    if
        K >= N -> 0;
        true ->
            dp(Costs, K, N, [])
    end.

dp(Costs, K, N, Memo) ->
    case lists:keyfind({K, N}, 1, Memo) of
        {_, Res} -> Res;
        false ->
            MinCost = lists:foldl(fun(End, Acc) ->
                Start = N - End + 1,
                Cost = lists:sum(lists:sublist(Costs, Start, End)),
                SubCost = if
                    K > 1 -> dp(Costs, K - 1, Start - 1, Memo);
                    true -> Cost
                end,
                min(Acc, Cost + SubCost)
            end, infinity, lists:seq(1, N)),
            [{K, N, MinCost} | Memo]
    end.