-module(solution).
-export([solve/2]).

solve(Height, S) ->
    N = length(Height),
    Best = -1,
    BestDist = infinity,
    solve(Height, S, 0, N, Best, BestDist).

solve(_, _, N, N, Best, _) ->
    Best;
solve(Height, S, I, N, Best, BestDist) ->
    case lists:nth(I+1, S) of
        $1 ->
            Dist = abs(I - Best),
            if
                Dist < BestDist ->
                    solve(Height, S, I+1, N, I, Dist);
                true ->
                    solve(Height, S, I+1, N, Best, BestDist)
            end;
        _ ->
            solve(Height, S, I+1, N, Best, BestDist)
    end.