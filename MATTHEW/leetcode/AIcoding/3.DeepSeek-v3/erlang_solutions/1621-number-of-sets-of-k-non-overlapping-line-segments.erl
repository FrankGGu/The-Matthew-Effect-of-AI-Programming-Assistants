-module(solution).
-export([number_of_sets/2]).

number_of_sets(N, K) ->
    DP = lists:duplicate(N + 1, lists:duplicate(K + 1, 0)),
    DP1 = lists:foldl(fun(I, Acc) -> 
        Row = lists:nth(I, Acc),
        NewRow = lists:keyreplace(1, 1, Row, {1, 0}),
        lists:keyreplace(I, 1, Acc, {I, NewRow})
    end, DP, lists:seq(1, N)),
    DP2 = lists:foldl(fun(I, Acc) -> 
        Row = lists:nth(I, Acc),
        NewRow = lists:keyreplace(1, 1, Row, {1, 1}),
        lists:keyreplace(I, 1, Acc, {I, NewRow})
    end, DP1, lists:seq(2, N)),
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc1) ->
            Row = lists:nth(I, Acc1),
            PrevRow = lists:nth(I - 1, Acc1),
            Val = (lists:nth(J, PrevRow) + lists:nth(J - 1, PrevRow) + lists:nth(J, Row)) rem 1000000007,
            NewRow = lists:keyreplace(J, 1, Row, {J, Val}),
            lists:keyreplace(I, 1, Acc1, {I, NewRow})
        end, Acc, lists:seq(1, K))
    end, DP2, lists:seq(2, N)),
    lists:nth(K + 1, lists:nth(N, DP2)).