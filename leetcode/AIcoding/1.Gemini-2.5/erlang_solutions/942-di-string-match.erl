-module(solution).
-export([di_string_match/1]).

di_string_match(S) ->
    N = length(S),
    solve(S, 0, N, []).

solve([], Low, _High, Acc) ->
    lists:reverse([Low | Acc]);
solve([H | T], Low, High, Acc) ->
    case H of
        $I -> solve(T, Low + 1, High, [Low | Acc]);
        $D -> solve(T, Low, High - 1, [High | Acc])
    end.