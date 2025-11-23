-module(sum_game).
-export([solve/1]).

solve(T) ->
    solve(T, 0, 0).

solve([], Sum, _Count) ->
    Sum;
solve([H|T], Sum, Count) ->
    case H of
        $+ -> solve(T, Sum + Count, 0);
        $- -> solve(T, Sum - Count, 0);
        _ -> solve(T, Sum, Count * 10 + (H - $0))
    end.