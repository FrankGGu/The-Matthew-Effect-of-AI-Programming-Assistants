-module(solution).
-export([max_score/1]).

max_score(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),
    DP = lists:duplicate(M, lists:duplicate(N, 0)),
    DP1 = setelement(1, setelement(1, DP, min(lists:nth(1, lists:nth(1, Grid)), lists:nth(1, lists:nth(2, Grid)), lists:nth(1, lists:nth(1, lists:nth(2, Grid))))), DP),
    DP2 = lists:foldl(fun(I, Acc) ->
        Row = lists:nth(I, Grid),
        MinVal = min(lists:nth(1, Row), lists:nth(2, Row)),
        setelement(I, setelement(1, Acc, MinVal + lists:nth(1, lists:nth(I-1, Acc))), Acc)
    end, DP1, lists:seq(2, M)),
    DP3 = lists:foldl(fun(J, Acc) ->
        Col = [lists:nth(J, Row) || Row <- Grid],
        MinVal = min(lists:nth(1, Col), lists:nth(2, Col)),
        setelement(1, setelement(J, Acc, MinVal + lists:nth(J-1, lists:nth(1, Acc))), Acc)
    end, DP2, lists:seq(2, N)),
    DP4 = lists:foldl(fun(I, AccI) ->
        lists:foldl(fun(J, AccJ) ->
            Val = min(lists:nth(J, lists:nth(I, Grid)), lists:nth(J, lists:nth(I-1, Grid)), lists:nth(J-1, lists:nth(I, Grid))),
            Prev = max(lists:nth(J-1, lists:nth(I, AccJ)), lists:nth(J, lists:nth(I-1, AccJ))),
            setelement(I, setelement(J, AccJ, Val + Prev), AccJ)
        end, AccI, lists:seq(2, N))
    end, DP3, lists:seq(2, M)),
    lists:nth(N, lists:nth(M, DP4)).