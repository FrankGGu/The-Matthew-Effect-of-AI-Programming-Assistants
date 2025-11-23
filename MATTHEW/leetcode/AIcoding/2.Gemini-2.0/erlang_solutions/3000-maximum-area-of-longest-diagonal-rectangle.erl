-module(max_area_longest_diagonal).
-export([solve/1]).

solve(Rectangles) ->
    solve(Rectangles, 0, 0).

solve([], MaxArea, MaxDiagonal) ->
    MaxArea;
solve([[L, W] | Rest], MaxArea, MaxDiagonal) ->
    Diagonal = L * L + W * W,
    Area = L * W,
    if Diagonal > MaxDiagonal ->
        solve(Rest, Area, Diagonal);
    Diagonal == MaxDiagonal ->
        if Area > MaxArea ->
            solve(Rest, Area, Diagonal);
        true ->
            solve(Rest, MaxArea, MaxDiagonal)
    true ->
        solve(Rest, MaxArea, MaxDiagonal)
    end.