-module(solution).
-export([solve/1]).

solve(S) ->
    solve(S, 0, 0).

solve([], Acc, Sum) ->
    Sum + Acc;
solve([H | T], Acc, Sum) when H >= $0, H =< $9 ->
    NewAcc = Acc * 10 + (H - $0),
    solve(T, NewAcc, Sum);
solve([_ | T], Acc, Sum) ->
    solve(T, 0, Sum + Acc).