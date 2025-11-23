-module(minimum_score_triangulation).
-export([min_score Triangulation/1]).

min_score_Triangulation(Points) ->
    N = length(Points),
    DP = array:new(N, {default, 0}),
    min_score_triangulation(Points, DP, 0, N-1, 0).

min_score_triangulation(_Points, _DP, I, J, _) when J - I < 2 -> 0;
min_score_triangulation(Points, DP, I, J, Score) ->
    case array:get(I, J, DP) of
        0 ->
            Min = lists:min([min_score_triangulation(Points, DP, I, K, Score + triangle_score(Points, I, K, J)) + min_score_triangulation(Points, DP, K, J, Score + triangle_score(Points, I, K, J)) || K <- lists:seq(I+1, J-1)]),
            array:set(I, J, Min, DP),
            Min;
        Val -> Val
    end.

triangle_score(Points, I, K, J) ->
    X1 = element(I+1, Points),
    Y1 = element(I+2, Points),
    X2 = element(K+1, Points),
    Y2 = element(K+2, Points),
    X3 = element(J+1, Points),
    Y3 = element(J+2, Points),
    (X1 * (Y2 - Y3) + X2 * (Y3 - Y1) + X3 * (Y1 - Y2)) div 2.