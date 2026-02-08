-module(solution).
-export([combination_sum_iii/2]).

combination_sum_iii(K, N) ->
    solve(K, N, 1).

solve(0, 0, _StartNum) ->
    [[]];
solve(0, _N, _StartNum) ->
    [];
solve(K, N, StartNum) when K < 0; N < 0; StartNum > 9 ->
    [];
solve(K, N, StartNum) ->
    lists:foldl(fun(I, Acc) ->
        SubCombinations = solve(K - 1, N - I, I + 1),
        CurrentCombinations = lists:map(fun(SubList) -> [I | SubList] end, SubCombinations),
        Acc ++ CurrentCombinations
    end, [], lists:seq(StartNum, 9)).