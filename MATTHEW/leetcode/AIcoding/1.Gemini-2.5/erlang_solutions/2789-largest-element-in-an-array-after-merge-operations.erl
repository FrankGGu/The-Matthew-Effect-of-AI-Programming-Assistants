-module(solution).
-export([solve/1]).

solve([]) -> 0;
solve(Nums) ->
    ReversedNums = lists:reverse(Nums),
    [Head | Tail] = ReversedNums,
    solve_recursive(Tail, Head, Head).

solve_recursive([], _CurrentMergedValue, MaxSoFar) ->
    MaxSoFar;
solve_recursive([H | T], CurrentMergedValue, MaxSoFar) ->
    If H =< CurrentMergedValue ->
        NewCurrentMergedValue = H + CurrentMergedValue,
        NewMaxSoFar = max(MaxSoFar, NewCurrentMergedValue),
        solve_recursive(T, NewCurrentMergedValue, NewMaxSoFar);
    Else ->
        NewCurrentMergedValue = H,
        NewMaxSoFar = max(MaxSoFar, NewCurrentMergedValue),
        solve_recursive(T, NewCurrentMergedValue, NewMaxSoFar)
    End.