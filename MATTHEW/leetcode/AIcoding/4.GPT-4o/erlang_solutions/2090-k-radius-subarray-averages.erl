-module(solution).
-export([get_averages/2]).

get_averages(N, K) ->
    Averages = lists:duplicate(N, -1),
    case N of
        0 -> Averages;
        _ ->
            Sum = lists:sum(lists:sublist(Averages, 1, K)),
            lists:foldl(fun(X, Acc) ->
                NewSum = Sum + X - lists:nth(K + 1, Averages),
                Averages = lists:substitute(Averages, K + 1, (NewSum div (2 * K + 1))),
                NewSum
            end, Sum, lists:sublist(Averages, K + 1, N - K))
    end.