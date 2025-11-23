-module(block_placement_queries).
-export([solve/1]).

solve(Queries) ->
    solve(Queries, 0, 0, 0).

solve([], _, _, _) ->
    [];
solve([{place, X}|T], Min, Max, Count) ->
    NewMin = min(Min, X),
    NewMax = max(Max, X),
    solve(T, NewMin, NewMax, Count + 1);
solve([{query, X}|T], Min, Max, Count) ->
    Result = if
        Count == 0 -> -1;
        true -> case (X >= Min andalso X <= Max) of
            true -> 1;
            false -> 0
        end
    end,
    [Result | solve(T, Min, Max, Count)];
solve([_|T], Min, Max, Count) ->
    solve(T, Min, Max, Count).