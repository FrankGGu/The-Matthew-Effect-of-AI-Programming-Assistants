-module(maximize_minimum_game_score).
-export([maximize_the_minimum_game_score/2]).

maximize_the_minimum_game_score(A, K) ->
    lists:foldl(fun(X, Acc) ->
                        case Acc of
                            {Sum, Min} ->
                                NewSum = Sum + X,
                                NewMin = min(Min, NewSum / K),
                                {NewSum, NewMin}
                        end
                end, {0, 1.0e10}, A) of
        {_, Result} ->
            Result
    end.