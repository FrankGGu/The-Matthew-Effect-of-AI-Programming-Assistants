-spec min_score_triangulation(Values :: [integer()]) -> integer().
min_score_triangulation(Values) ->
    N = length(Values),
    DP = [ [0 || _ <- lists:seq(1, N)] || _ <- lists:seq(1, N) ],
    min_score_triangulation(Values, DP, 0, N - 1).

min_score_triangulation(Values, DP, I, J) when J - I + 1 < 3 ->
    0;
min_score_triangulation(Values, DP, I, J) ->
    case element(J + 1, element(I + 1, DP)) of
        0 ->
            MinScore = lists:min(
                [min_score_triangulation(Values, DP, I, K) + 
                 min_score_triangulation(Values, DP, K, J) + 
                 lists:nth(I + 1, Values) * lists:nth(K + 1, Values) * lists:nth(J + 1, Values) 
                 || K <- lists:seq(I + 1, J - 1)]
            ),
            DP1 = setelement(I + 1, DP, setelement(J + 1, element(I + 1, DP), MinScore)),
            MinScore;
        Cached -> Cached
    end.