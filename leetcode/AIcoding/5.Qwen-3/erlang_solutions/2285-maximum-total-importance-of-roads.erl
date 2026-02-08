-module(max_total_importance).
-export([maximumTotalImportance/2]).

maximumTotalImportance(N, Roads) ->
    Importances = lists:seq(1, N),
    {_, Total} = lists:foldl(fun(Road, {Imps, Acc}) ->
        [A, B] = Road,
        AVal = lists:nth(A, Imps),
        BVal = lists:nth(B, Imps),
        NewImps = lists:sublist(Imps, A-1) ++ [AVal + 1] ++ lists:sublist(Imps, A+1, length(Imps) - A) ++
                  lists:sublist(Imps, B-1) ++ [BVal + 1] ++ lists:sublist(Imps, B+1, length(Imps) - B),
        {NewImps, Acc + AVal + BVal}
    end, {Importances, 0}, Roads),
    Total.