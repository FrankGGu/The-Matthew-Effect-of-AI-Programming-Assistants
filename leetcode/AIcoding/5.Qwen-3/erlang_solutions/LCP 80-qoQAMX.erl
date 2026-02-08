-module(solution).
-export([solve/1]).

solve(Biomes) ->
    solve(Biomes, 0, []).

solve([], _, Result) ->
    lists:reverse(Result);
solve([H | T], Index, Result) ->
    case H of
        'B' -> solve(T, Index + 1, [Index | Result]);
        _ -> solve(T, Index + 1, Result)
    end.