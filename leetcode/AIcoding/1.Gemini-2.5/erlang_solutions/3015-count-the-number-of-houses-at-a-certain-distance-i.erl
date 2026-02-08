-module(solution).
-export([count_houses/3]).

count_houses(N, X_orig, Y_orig) ->
    {X, Y} = if X_orig =< Y_orig -> {X_orig, Y_orig};
               true -> {Y_orig, X_orig}
             end,

    Ans0 = lists:duplicate(N, 0),

    lists:foldl(fun(I, CurrentAns) ->
        lists:foldl(fun(J, InnerAns) ->
            Dist = calculate_distance(I, J, X, Y),
            OldCount = lists:nth(Dist, InnerAns),
            lists:replace_nth(Dist, OldCount + 1, InnerAns)
        end, CurrentAns, lists:seq(I + 1, N))
    end, Ans0, lists:seq(1, N - 1)).

calculate_distance(I, J, X, Y) ->
    Path1 = abs(I - J),
    Path2 = abs(I - X) + 1 + abs(J - Y),
    Path3 = abs(I - Y) + 1 + abs(J - X),
    min(Path1, min(Path2, Path3)).