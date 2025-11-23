-module(solution).
-export([min_score_triangulation/1]).

min_score_triangulation(Points) ->
    N = length(Points),
    Memo = lists:duplicate(N, lists:duplicate(N, -1)),
    triangulate(Points, 0, N - 1, Memo).

triangulate(_, I, J, Memo) when J - I < 2 -> 0;
triangulate(Points, I, J, Memo) ->
    case Memo I J of
        -1 ->
            MinScore = lists:foldl(
                fun(K, Acc) ->
                    Score = Points I] * Points K] * Points J] + triangulate(Points, I, K, Memo) + triangulate(Points, K, J, Memo),
                    min(Acc, Score)
                end,
                infinity,
                lists:seq(I + 1, J - 1)
            ),
            Memo1 = put_memo(Memo, I, J, MinScore),
            MinScore;
        Score -> Score
    end.

put_memo(Memo, I, J, Value) ->
    lists:mapfun(fun({X, Y}) ->
        case {X, Y} of
            {I, J} -> Value;
            _ -> Memo X Y
        end
    end, lists:zip(lists:seq(0, length(Memo) - 1), lists:duplicate(length(Memo), -1))).