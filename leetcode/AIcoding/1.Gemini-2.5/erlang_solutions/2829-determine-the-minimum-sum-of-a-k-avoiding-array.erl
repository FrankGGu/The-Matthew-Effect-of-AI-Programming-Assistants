-module(solution).
-export([solve/2]).

solve(N, K) ->
    solve_recursive(N, K, 1, 0, gb_sets:new()).

solve_recursive(0, _K, _CurrentNum, AccSum, _AddedNumbers) ->
    AccSum;
solve_recursive(N, K, CurrentNum, AccSum, AddedNumbers) ->
    Forbidden = K - CurrentNum,
    if gb_sets:is_element(Forbidden, AddedNumbers) ->
        solve_recursive(N, K, CurrentNum + 1, AccSum, AddedNumbers);
    true ->
        solve_recursive(N - 1, K, CurrentNum + 1, AccSum + CurrentNum, gb_sets:add_element(CurrentNum, AddedNumbers))
    end.